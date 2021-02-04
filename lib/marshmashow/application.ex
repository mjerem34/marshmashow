defmodule Marshmashow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Marshmashow.Repo,
      # Start the Telemetry supervisor
      MarshmashowWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Marshmashow.PubSub},
      # Start the Endpoint (http/https)
      MarshmashowWeb.Endpoint
      # Start a worker by calling: Marshmashow.Worker.start_link(arg)
      # {Marshmashow.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Marshmashow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MarshmashowWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
