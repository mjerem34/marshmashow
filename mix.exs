defmodule Marshmashow.Mixfile do
  use Mix.Project

  def project do
    [app: :marshmashow,
     version: "0.0.1",
     elixir: "~> 1.11.3",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Marshmashow.Application, []},
    applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                   :phoenix_ecto, :postgrex, :ueberauth, :ueberauth_google, :arc_ecto,
                   :ex_aws, :httpoison, :poison]]
 end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.5"},
     {:phoenix_pubsub, "~> 2.0"},
     {:phoenix_ecto, "~> 4.2"},
     {:ecto_sql, "~> 3.5"},
     {:postgrex, "~> 0.15"},
     {:phoenix_html, "~> 2.14"},
     {:phoenix_live_reload, "~> 1.3"},
     {:phoenix_live_dashboard, "~> 0.4"},
     {:gettext, "~> 0.18"},
     {:telemetry_metrics, "~> 0.4"},
     {:telemetry_poller, "~> 0.4"},
     {:plug_cowboy, "~> 2.0"},
     {:cowboy, "~> 2.8"},
     {:ueberauth, "~> 0.6"},
     {:ueberauth_google, "~> 0.10"},
     {:font_awesome_phoenix, "~> 1.0"},
     {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
     {:arc, "~> 0.11"},
     {:arc_ecto, "~> 0.11"},
     {:ex_aws, "~> 2.1"},
     {:poison, "~> 3.1"},
     {:httpoison, "~> 1.8"},
     {:tvmaze_wrapper, "~> 0.1.5"},
     {:navigation_history, "~> 0.3"},
     {:comeonin, "~> 5.3"},
     {:bcrypt_elixir, "~> 2.3"},
     {:guardian, "~> 2.1"},
     {:cors_plug, "~> 2.0"},
     {:turbolinks, "~> 1.0"},
     {:jason, "~> 1.0"}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     test: ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
