defmodule ComplexityTest do
  use ExUnit.Case
  doctest Complexity

  test "String" do
    assert Complexity.complexity("foo") == 1
  end

  test "Atom" do
    assert Complexity.complexity(:foo) == 1
  end

  test "Integer" do
    assert Complexity.complexity(42) == 1
  end

  test "List" do
    assert Complexity.complexity([]) == 1
    assert Complexity.complexity([1, 2, 3, 4]) == 5
  end

  test "Map" do
    assert Complexity.complexity(%{}) == 1
    assert Complexity.complexity(%{a: 1, b: 2}) == 5
  end

  test "everything" do
    everything = %{a: "hi", b: [1, :foo, "42"], c: %{d: :e}}
    assert Complexity.complexity(everything) == 12
  end
end
