defmodule ElixirMarkovChain do
  @moduledoc """
    Simple implementation of Markov chain in Elixir. Generates random
    sentences from source file.
  """

  require Logger
  alias ElixirMarkovChain.Model
  alias ElixirMarkovChain.Generator

  def start(_type, _args) do
    {:ok, model} = Model.start_link

    Application.get_env(:elixir_markov_chain, :source_file)
    |> File.stream!
    |> Stream.chunk(10)
    |> Enum.each(fn(chunk) ->
      chunk |> Enum.join |> Model.populate(model)
    end)

    create_sentence(model, 5)

    System.halt 0
  end

  defp create_sentence(model, count) do
    Stream.each(1..count, fn(_) ->
      model |> Generator.create_sentence |> Logger.info
    end)
  end
end
