defmodule Marshmashow.Repo do
  use Ecto.Repo,
    otp_app: :marshmashow,
    adapter: Ecto.Adapters.Postgres
end
