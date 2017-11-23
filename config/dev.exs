use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :marshmashow, MarshmashowWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../assets", __DIR__)]]


# Watch static and templates for browser reloading.
config :marshmashow, MarshmashowWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/marshmashow_web/views/.*(ex)$},
      ~r{lib/marshmashow_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :marshmashow, Marshmashow.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRE_USER_NAME"),
  password: System.get_env("POSTGRE_USER_PASSWORD"),
  database: "marshmashow_dev",
  hostname: "localhost",
  pool_size: 10

config :arc,
  bucket: "marshmashow-s3",
  virtual_host: true
config :ex_aws,
  access_key_id: System.get_env("S3_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("S3_SECRET_ACCESS_KEY"),
  region: "us-west-2",
  host: "s3-us-west-2.amazonaws.com",
  s3: [
  scheme: "https://",
  host: "s3-us-west-2.amazonaws.com",
  region: "us-west-2"
 ]
