defmodule AnacondaTest do
  use ExUnit.Case
  doctest Anaconda

  test "the truth" do
    assert true
  end

  test "con numerical" do
    tuples = Anaconda.range_from_chars('0', '9') |> Enum.to_list |> List.to_tuple
    modulus = tuple_size(tuples)
    # TODO it seems the modulus is always tuple_size(tuples), so why pass the argument to the
    # function?
    assert "0" == Anaconda.con(0, modulus, tuples)
    assert "1" == Anaconda.con(1, modulus, tuples)
    assert "2" == Anaconda.con(2, modulus, tuples)
    assert "9" == Anaconda.con(9, modulus, tuples)
    assert "10" == Anaconda.con(10, modulus, tuples)
    assert "100" == Anaconda.con(100, modulus, tuples)
    assert "1001" == Anaconda.con(1001, modulus, tuples)
    assert "1002" == Anaconda.con(1002, modulus, tuples)
  end

  test "con alphabetical" do
    tuples = Anaconda.range_from_chars('a', 'z') |> Enum.to_list |> List.to_tuple
    modulus = tuple_size(tuples)
    assert "a" == Anaconda.con(0, modulus, tuples)
    assert "b" == Anaconda.con(1, modulus, tuples)
    assert "c" == Anaconda.con(2, modulus, tuples)
    assert "aa" == Anaconda.con(26, modulus, tuples)
    assert "ab" == Anaconda.con(27, modulus, tuples)
    assert "aaa" == Anaconda.con(52, modulus, tuples)
  end
end
