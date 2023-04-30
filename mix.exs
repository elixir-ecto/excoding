defmodule Excoding.MixProject do
  use Mix.Project

  @version "0.1.5"

  def project do
    [
      app: :excoding,
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description:
        "String encoding/decoding NIF using rust [encoding](https://crates.io/crates/encoding) library",
      package: package()
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
      {:rustler_precompiled, "~> 0.5"},
      {:rustler, ">= 0.0.0", optional: true},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      name: "excoding",
      maintainers: ["Kevin Seidel"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/moogle19/excoding"},
      files: ~w(.formatter.exs mix.exs README.md lib native checksum-*.exs)
    ]
  end
end
