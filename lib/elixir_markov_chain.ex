defmodule ElixirMarkovChain do
  @source_file "/data/source.txt"

  def start(_type, _args) do
    case File.read("#{System.cwd}#{@source_file}") do
       {:ok, body} ->
         {:ok, model} = ElixirMarkovChain.Model.start_link
         ElixirMarkovChain.Model.populate model, body
       {:error, reason} -> IO.inspect reason
    end

    System.halt 0
  end
end
