require IEx

defmodule ElixirMarkovChain do
  @source_file "/data/source.txt"

  def start(_type, _args) do
    case File.read("#{System.cwd}#{@source_file}") do
       {:ok, body} -> process_source body
       {:error, reason} -> IO.inspect reason
    end
  end

  defp process_source(text) do
    res = text
      |> String.split(~r{\n}, trim: true)
      |> Enum.map(&String.downcase/1)
    IEx.pry
  end
end
