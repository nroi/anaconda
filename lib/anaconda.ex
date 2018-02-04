defmodule Anaconda do
  def range_from_chars([start], [endd]) do
    start..endd
  end

  def chars() do
    first_range = range_from_chars('a', 'z')
    second_range = range_from_chars('0', '9')
    chars = Enum.to_list(first_range) ++ Enum.to_list(second_range)
    List.to_tuple(chars)
  end

  def string_hash_fixed_length(s) do
    len = Application.fetch_env!(:anaconda, :length)
    string_hash_fixed_length(s, len)
  end

  def string_hash_fixed_length(s, len) do
    c = chars()
    max_index = trunc(:math.pow(tuple_size(c), len))
    index = rem(:crypto.bytes_to_integer(:crypto.hash(:sha, s)), max_index)
    string_from_index(index, c, len)
  end

  def string_from_index(index, chars, len)
      when is_integer(index) and is_tuple(chars) and is_integer(len) do
    if index > :math.pow(tuple_size(chars), len) do
      raise "Index out of range"
    else
      s = string_from_index(index, chars)
      padding_char = to_string([elem(chars, 0)])
      String.pad_leading(s, len, padding_char)
    end
  end

  defp string_from_index(index, chars) when index < tuple_size(chars) do
    to_string([elem(chars, rem(index, tuple_size(chars)))])
  end

  defp string_from_index(index, chars) when is_integer(index) and is_tuple(chars) do
    modulus = tuple_size(chars)
    new_char = to_string([elem(chars, rem(index, modulus))])
    new_index = div(index, modulus)
    string_from_index(new_index, chars) <> new_char
  end
end
