defmodule ElixirMarkovChain do
  @source_file "/data/source.txt"

  def start(_type, _args) do
    case File.read("#{System.cwd}#{@source_file}") do
       {:ok, body} -> ElixirMarkovChain.Model.populate body
       {:error, reason} -> IO.inspect reason
    end

    Supervisor.start_link [], strategy: :one_for_one
  end
end
