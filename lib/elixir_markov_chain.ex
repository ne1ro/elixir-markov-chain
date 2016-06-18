defmodule ElixirMarkovChain do
  @moduledoc """
    Simple implementation of Markov chain in Elixir. Generates random
    sentences from source file.
  """

  alias ElixirMarkovChain.Model
  alias ElixirMarkovChain.Generator

  def start(_type, _args) do
    case File.read(Application.get_env :elixir_markov_chain, :source_file) do
       {:ok, body} -> process_source body
       {:error, reason} -> IO.puts reason
    end

    System.halt 0
  end

  defp process_source(text) do
    {:ok, model} = Model.start_link
    model = Model.populate model, text

    Enum.each(1..20, fn(_) -> model |> Generator.create_sentence |> IO.puts end)
  end
end
