defmodule MarshmashowWeb.UserController do
  use MarshmashowWeb, :controller

  plug(MarshmashowWeb.Plugs.RequireAuth when action in [:my_shows])

  alias Marshmashow.UsersShow
  alias Marshmashow.User
  def my_shows(%{assigns: %{user: user}} = conn, _params) do
    users_show =
      UsersShow |> Ecto.Query.where(user_id: ^user.id) |> Repo.all
      |> Repo.preload(:show)
    render(conn, "my_shows.html", users_show: users_show)
  end

  def create(conn, params) do
    changeset = User.registration_changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user, :access)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> render(Marshmashow.SessionView, "show.json", user: user, jwt: jwt)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Marshmashow.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
