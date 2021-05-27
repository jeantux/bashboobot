defmodule Bashboobot.MixProject do
  use Mix.Project

  def project do
    [
      app: :bashboobot,
      version: "0.1.0",
      elixir: "~> 1.11",
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

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "0.30.0"},
      {:tesla, "1.4.0"}
    ]
  end
end
