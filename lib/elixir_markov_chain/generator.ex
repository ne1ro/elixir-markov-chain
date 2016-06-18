defmodule ElixirMarkovChain.Generator do
  alias ElixirMarkovChain.Model

  def create_sentence(pid) do
    { sentence, prob } = build_sentence pid

    cond do
      prob >= Application.get_env(:elixir_markov_chain, :treshold) ->
        sentence |> Enum.join(" ")
      true -> create_sentence pid
    end
  end

  defp complete?(tokens) do
    length(tokens) >= :random.uniform(15) + 5
  end

  defp build_sentence(pid), do: build_sentence(pid, [], 0.0, 0.0)
  defp build_sentence(pid, tokens, prob_acc, new_tokens \\ 0.0) do
    { token, prob } = Model.fetch_state(tokens) |> Model.fetch_token(pid)

    case complete?(tokens) do
      true ->
        score = case new_tokens == 0 do
          true -> 1.0
          _ -> prob_acc / new_tokens
        end
        { tokens, score }
      _ ->
        build_sentence pid, tokens ++ [token], prob + prob_acc, new_tokens + 1
    end
  end
end
