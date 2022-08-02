defmodule Excoding.MixProject do
  use Mix.Project

  def project do
    [
      app: :excoding,
      version: "0.1.0",
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
      extra_applications: [:rustler]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.25.0"},
      {:rustler_precompiled, "~> 0.5"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      name: "excoding",
      maintainers: ["Kevin Seidel"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/moogle19/excoding"},
      files: ~w(.formatter.exs mix.exs README.md lib native)
    ]
  end
end
