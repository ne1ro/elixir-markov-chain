defmodule ElixirMarkovChain do
  alias ElixirMarkovChain.Model
  alias ElixirMarkovChain.Generator

  def start(_type, _args) do
    case File.read(Application.get_env :elixir_markov_chain, :source_file) do
       {:ok, body} -> process_source body
       {:error, reason} -> IO.inspect reason
    end

    System.halt 0
  end

  defp process_source(text) do
    {:ok, model} = Model.start_link
    model
      |> Model.populate(text)
      |> Generator.create_sentence
      |> IO.puts
  end
end
