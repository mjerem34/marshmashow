# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :marshmashow,
  ecto_repos: [Marshmashow.Repo]

# Configures the endpoint
config :marshmashow, MarshmashowWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("MARSHMASHOW_DEV_SECRET_KEY_BASE"),
  render_errors: [view: MarshmashowsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Marshmashows.PubSub,
  live_view: [signing_salt: "TeEQIugC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
config :phoenix, :json_library, Jason
# UBERAUTH -------------------------
# # GOOGLE
config :ueberauth, Ueberauth,
  providers: [
    google: { Ueberauth.Strategy.Google, [] }
  ]
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_OAUTH_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_OAUTH_CLIENT_SECRET")
# # UBERAUTH -------------------------

config :marshmashow, Marshmashow.Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "marshmashow",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: System.get_env("MARSHMASHOW_GUARDIAN_SECRET_KEY"),
  serializer: Marshmashow.GuardianSerializer
