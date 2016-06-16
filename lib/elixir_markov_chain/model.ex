require IEx

defmodule ElixirMarkovChain.Model do
  def populate(text) do
    text
      |> tokenize
      |> Enum.map(&modelize/1)
  end

  defp tokenize(text) do
    text
      |> String.downcase
      |> String.split(~r{\n}, trim: true)
      |> Enum.map(&String.split/1)
  end

  defp modelize(tokens) do
    tokens
      |> Enum.with_index
      |> Enum.map(fn({token, id}) ->
        current_state = state tokens, id
        IO.inspect current_state
      end)
  end

  defp state(_tokens, id) when id == 0, do: { nil, nil }
  defp state([head | _tail], id) when id == 1, do: { nil, head }
  defp state(tokens, id) do
    tokens
      |> Enum.slice(id - 2..id - 1)
      |> List.to_tuple
  end
end
