defmodule ElixirMarkovChain.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_markov_chain,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: ElixirMarkovChain.Scraper, name: "scrape", path: "#{System.cwd}/bin/scrape"],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :mongo],
     mod: {ElixirMarkovChain, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
     [{:mongo, "~> 0.5.4"},
     {:credo, "~> 0.4", only: [:dev, :test]}]
  end
end
