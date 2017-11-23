defmodule MarshmashowWeb.Router do
  use MarshmashowWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MarshmashowWeb.Plugs.SetUser
    plug NavigationHistory.Tracker
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", MarshmashowWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/fill_in", ShowController, :fill_in, as: :fill_in
    get "/check", ShowController, :check, as: :check
    get "/signout", AuthController, :signout
    get "/my_shows", UserController, :my_shows
    get "/search", ShowController, :search
    post "/search", ShowController, :search
  end

  scope "/auth", MarshmashowWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/show", MarshmashowWeb do
    pipe_through :browser

    resources "/", ShowController do
      post "/follow", ShowController, :follow, as: :follow
      delete "/unfollow", ShowController, :unfollow, as: :unfollow
      resources "/episode", EpisodeController do
        post "/watch", EpisodeController, :watch, as: :watch
        delete "/unwatch", EpisodeController, :unwatch, as: :unwatch
      end
    end

  end

  # Other scopes may use custom stacks.
  scope "/api", Marshmashow do
    pipe_through :api

    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    resources "/users", UserController, only: [:create]
  end
end
