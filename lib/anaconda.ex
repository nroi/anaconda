defmodule Anaconda do
  defp range_from_chars([start], [endd]) do
    start..endd
  end

  def chars() do
    first_range = range_from_chars('a', 'z')
    second_range = range_from_chars('A', 'Z')
    third_range = range_from_chars('0', '9')
    chars = Enum.to_list(first_range) ++ Enum.to_list(second_range) ++ Enum.to_list(third_range)
    List.to_tuple(chars)
  end

  def random_string() do
    len = Application.fetch_env!(:anaconda, :length)
    random_string("", len, chars())
  end

  def random_string(s, len, _chars) when byte_size(s) >= len, do: s

  def random_string(s, len, chars) when byte_size(s) < len do
    idx = :rand.uniform(tuple_size(chars))
    new_string = s <> to_string([elem(chars, idx - 1)])
    random_string(new_string, len, chars)
  end
end
