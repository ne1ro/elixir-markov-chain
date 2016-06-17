defmodule ElixirMarkovChain.Generator do
  alias ElixirMarkovChain.Model

  def create_sentence(pid) do
    build_sentence(pid) |> Enum.join(" ") |> IO.inspect
  end

  defp complete?(tokens), do: length(tokens) == 7 # TODO: random or from conf

  defp build_sentence(pid), do: build_sentence(pid, [])
  defp build_sentence(pid, tokens) do
    { token, _ } = Model.fetch_state(tokens) |> Model.fetch_token(pid)

    case complete?(tokens) do
      true -> tokens
      _ -> build_sentence(pid, [tokens ++ [token]] )
    end
  end
end
