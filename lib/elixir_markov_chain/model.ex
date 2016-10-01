defmodule ElixirMarkovChain.Model do
  @moduledoc """
    Markov chain model implementation
  """

  import ElixirMarkovChain.Tokenizer

  def start_link, do: Agent.start_link(fn -> %{} end)

  def populate(text, pid) do
    for tokens <- tokenize(text), do: modelize(pid, tokens)
    pid
  end

  def fetch_token(state, pid) do
    tokens = fetch_tokens(state, pid)

    if length(tokens) > 0 do
      token = Enum.random(tokens)
      count = tokens |> Enum.count(&(token == &1))

      {token, count / length(tokens)}
    else
      {"", 0.0}
    end
  end

  def fetch_state(tokens), do: fetch_state(tokens, length(tokens))
  defp fetch_state(_tokens, id) when id == 0, do: {nil, nil}
  defp fetch_state([head | _tail], id) when id == 1, do: {nil, head}
  defp fetch_state(tokens, id) do
    tokens
      |> Enum.slice(id - 2..id - 1)
      |> List.to_tuple
  end

  defp fetch_tokens(state, pid), do: Agent.get pid, &(&1[state] || [])

  defp modelize(pid, tokens) do
    for {token, id} <- Enum.with_index(tokens) do
      tokens |> fetch_state(id) |> add_state(pid, token)
    end
  end

  defp add_state(state, pid, token) do
    Agent.update pid, fn(model) ->
      current_state = model[state] || []
      Map.put(model, state, [token | current_state])
    end
  end
end
