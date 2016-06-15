require IEx

defmodule ElixirMarkovChain do
  @source_file "/data/source.txt"

  def start(_type, _args) do
    case File.read("#{System.cwd}#{@source_file}") do
       {:ok, body} ->
         res = body |> tokenize |> Enum.map(&modelize/1)
         IEx.pry
       {:error, reason} -> IO.inspect reason
    end
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
      |> Enum.map(fn({token, id}) -> fetch_state tokens, id end)
  end

  defp fetch_state(_tokens, id) when id == 0, do: { nil, nil }
  defp fetch_state([head | _tail], id) when id == 1, do: { nil, head }
  defp fetch_state(tokens, id) do
    tokens
      |> Enum.slice(id - 2..id - 1)
      |> List.to_tuple
  end
end
