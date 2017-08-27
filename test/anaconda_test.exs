defmodule AnacondaTest do
  use ExUnit.Case
  doctest Anaconda

  test "greets the world" do
    assert Anaconda.hello() == :world
  end
end
