use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :marshmashow, MarshmashowWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :marshmashow, Marshmashow.Repo,
  username: "postgres",
  password: "postgres",
  database: "marshmashow_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
