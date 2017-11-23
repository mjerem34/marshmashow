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
  # http: [port: {:system, "80"}, ip: {192,168,43,90}],
  url: [host: {127,0,0,1}],
  secret_key_base: System.get_env("MARSHMASHOW_DEV_SECRET_KEY_BASE"),
  render_errors: [view: MarshmashowWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Marshmashow.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

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

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Marshmashow",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: System.get_env("MARSHMASHOW_GUARDIAN_SECRET_KEY"),
  serializer: Marshmashow.GuardianSerializer
