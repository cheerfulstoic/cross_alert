defmodule CrossAlert.MixProject do
  use Mix.Project

  def project do
    [
      app: :cross_alert,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:csv, "~> 2.3"},
      {:jason, "~> 1.0"},
      {:httpoison, "~> 1.5"},
      {:timex, "~> 3.5.0"},
      {:twittex, "~> 0.3.6"},
    ]
  end
end
