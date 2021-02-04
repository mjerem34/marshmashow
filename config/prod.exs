use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :marshmashow, Marshmashow.Repo,
  url: database_url,
  username: System.get_env("POSTGRE_USER_NAME"),
  password: System.get_env("POSTGRE_USER_PASSWORD"),
  database: System.get_env("POSTGRE_DATABASE_NAME"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE")) || "10",
  pool_timeout: 10_000,
  timeout: 10_000,
  ssl: true

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :marshmashow, MarshmashowWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  url: [scheme: "https", host: "marshmashow.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: secret_key_base

config :logger, level: :info
# import_config "prod.secret.exs"

config :arc,
  bucket: "marshmashow",
  virtual_host: true
config :ex_aws,
  access_key_id: System.get_env("S3_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("S3_SECRET_ACCESS_KEY"),
  region: "eu-west-3",
  host: "s3-eu-west-3.amazonaws.com",
  s3: [
    scheme: "https://",
    host: "s3-eu-west-3.amazonaws.com",
    region: "eu-west-3"
  ]
