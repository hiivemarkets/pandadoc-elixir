defmodule Pandadoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :pandadoc_api,
      version: "0.0.3",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/stueccles/pandadoc-elixir",
      docs: [main: "Pandadoc"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:tesla, :hackney, :logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.18"},
      {:jason, ">= 1.0.0"},
      {:plug, "~> 1.8", optional: true},
      {:mox, "~> 0.5", only: :test}
    ]
  end

  defp description do
    "Elixir SDK for Pandadoc APIs"
  end

  defp package do
    [
      name: "pandadoc_api",
      # These are the default files included in the package
      files: ~w(lib config .formatter.exs mix.exs README* LICENSE* ),
      licenses: ["MIT License"],
      links: %{"GitHub" => "https://github.com/hiivemarkets/pandadoc-elixir"}
    ]
  end
end
