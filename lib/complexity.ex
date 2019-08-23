defprotocol Complexity do
  @moduledoc """
  Complexity indicates how complex an item is, meaning if the item was represented
  as a tree, how many nodes would it have.
  Strings, Atoms, and Integers are complexity 1.
  Lists are complexity one plus the sum of the complexities of its entities.
  Maps are complexity one plus one for each key plus the sum of the complexities of its values.

  """
  @spec complexity(any) :: integer()
  def complexity(item)
end

defimpl Complexity, for: [BitString, Atom, Integer] do
  def complexity(_), do: 1
end

defimpl Complexity, for: List do
  def complexity([h | t]), do: Complexity.complexity(h) + Complexity.complexity(t)
  def complexity([]), do: 1
end

defimpl Complexity, for: Map do
  def complexity(map) do
    map
    |> Map.to_list()
    |> case do
      [] ->
        1

      [{key, val} | _] ->
        1 + Complexity.complexity(val) + Complexity.complexity(Map.delete(map, key))
    end
  end
end

defimpl Complexity, for: PID do
  @moduledoc """
  The complexity of a GenServer/Agent is 1 plus the complexity of its state
  """
  def complexity(genserver_pid) do
    genserver_pid
    |> :sys.get_state()
    |> Complexity.complexity()
    |> Kernel.+(1)
  end
end
