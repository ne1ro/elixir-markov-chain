defmodule ElixirMarkovChain.Model do
  import ElixirMarkovChain.Tokenizer

  def start_link, do: Agent.start_link(fn -> %{} end)

  def populate(pid, text) do
    for tokens <- tokenize(text), do: modelize(pid, tokens)
  end

  defp modelize(pid, tokens) do
    for {token, id} <- Enum.with_index(tokens) do
      fetch_state(tokens, id) |> add_state(pid, token)
    end
  end

  defp fetch_state(_tokens, id) when id == 0, do: { nil, nil }
  defp fetch_state([head | _tail], id) when id == 1, do: { nil, head }
  defp fetch_state(tokens, id) do
    tokens
      |> Enum.slice(id - 2..id - 1)
      |> List.to_tuple
  end

  defp add_state(state, pid, token) do
    Agent.update pid, fn(model) ->
      current_state = model[state] || []
      Map.put model, state, [token | current_state]
    end
  end
end
