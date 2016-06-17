defmodule ElixirMarkovChain do
  alias ElixirMarkovChain.Model
  alias ElixirMarkovChain.Generator

  def start(_type, _args) do
    case File.read(Application.get_env :elixir_markov_chain, :source_file) do
       {:ok, body} ->
         {:ok, model} = Model.start_link
         Model.populate model, body
         Generator.create_sentence model
       {:error, reason} -> IO.inspect reason
    end

    System.halt 0
  end
end
