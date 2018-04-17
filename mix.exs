defmodule Marshmashow.Mixfile do
  use Mix.Project

  def project do
    [app: :marshmashow,
     version: "0.0.1",
     elixir: "~> 1.6.0-rc.0",
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
                   :phoenix_ecto, :postgrex, :ueberauth, :ueberauth_google, :arc_ecto, :ex_aws, :httpoison, :poison]]
 end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.3.2"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0"},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:ueberauth, "~> 0.4"},
     {:ueberauth_google, "~> 0.5"},
     {:font_awesome_phoenix, "~> 0.1"},
     {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
     {:arc, github: "stavro/arc", override: true},
     {:arc_ecto, github: "stavro/arc_ecto"},
     {:ex_aws, "~> 1.1.3"},
     {:poison, "~> 3.0"},
     {:httpoison, "~> 0.13.0"},
     {:tvmaze_wrapper, "~> 0.1.4"},
     {:navigation_history, "~> 0.0"},
     {:comeonin, "~> 4.0"},
     {:bcrypt_elixir, "~> 0.12.0"},
     {:guardian, "~> 0.14"},
     {:cors_plug, "~> 1.2"},
     {:turbolinks, "~> 0.3.2"}]
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
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
