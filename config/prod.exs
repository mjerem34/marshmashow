use Mix.Config
config :marshmashow, MarshmashowWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "marshmashow.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")


config :marshmashow, Marshmashow.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  username: System.get_env("POSTGRE_USER_NAME"),
  password: System.get_env("POSTGRE_USER_PASSWORD"),
  database: System.get_env("POSTGRE_DATABASE_NAME"),
  pool_size: 10,
  pool_timeout: 10_000,
  timeout: 10_000,
  ssl: true


config :logger, level: :info
# import_config "prod.secret.exs"

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
