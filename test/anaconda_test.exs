defmodule AnacondaTest do
  use ExUnit.Case
  doctest Anaconda

  test "string_from_index returns correct numbers" do
    chars = Anaconda.range_from_chars('0', '9') |> Enum.to_list() |> List.to_tuple()
    len = 4
    assert "0000" == Anaconda.string_from_index(0, chars, len)
    assert "0001" == Anaconda.string_from_index(1, chars, len)
    assert "0002" == Anaconda.string_from_index(2, chars, len)
    assert "0009" == Anaconda.string_from_index(9, chars, len)
    assert "0010" == Anaconda.string_from_index(10, chars, len)
    assert "0100" == Anaconda.string_from_index(100, chars, len)
    assert "1001" == Anaconda.string_from_index(1001, chars, len)
    assert "1002" == Anaconda.string_from_index(1002, chars, len)
  end

  test "string_from_index returns correct character strings" do
    chars = Anaconda.range_from_chars('a', 'z') |> Enum.to_list() |> List.to_tuple()
    len = 2
    assert "aa" == Anaconda.string_from_index(0, chars, len)
    assert "ab" == Anaconda.string_from_index(1, chars, len)
    assert "ac" == Anaconda.string_from_index(2, chars, len)
    assert "ba" == Anaconda.string_from_index(26, chars, len)
    assert "bb" == Anaconda.string_from_index(27, chars, len)
    assert "ca" == Anaconda.string_from_index(52, chars, len)
  end
end
