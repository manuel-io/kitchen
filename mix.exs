defmodule KitchenLog.MixProject do
  use Mix.Project

  def project do
    [
      app: :kitchenlog,
      releases: [
        kitchenlog: [
          include_executables_for: [:unix],
          path: "/home/manuel/current"
        ]
      ],
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      env: [ secret_key: EntropyString.random(:token, :charset16) ],
      extra_applications: [:logger],
      mod: { KitchenLog.Application, [] }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, "0.15.9"},
      {:ecto, "~> 3.6.2"},
      {:ecto_sql, "~> 3.6.2"},
      {:entropy_string, "~> 1.3"},
      {:mix_systemd, "~> 0.7"},
      {:poison, "~> 3.1"},
      {:bcrypt_elixir, "~> 2.3.0"},
    ]
  end
end
