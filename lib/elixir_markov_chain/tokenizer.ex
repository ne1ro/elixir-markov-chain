defmodule ElixirMarkovChain.Tokenizer do
  def tokenize(text) do
    text
      |> String.downcase
      |> String.split(~r{\n}, trim: true)
      |> Enum.map(&String.split/1)
  end
end
