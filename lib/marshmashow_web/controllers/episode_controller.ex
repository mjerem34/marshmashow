defmodule MarshmashowWeb.EpisodeController do
  use MarshmashowWeb, :controller

  alias Marshmashow.Episode
  alias Marshmashow.Show
  alias Marshmashow.UsersEpisode
  alias Marshmashow.UsersShow

  plug MarshmashowWeb.Plugs.RequireAuth
  plug(:set_show when action in [:index, :create, :new, :edit, :delete])

  def index(%{assigns: %{show: show, user: user}} = conn, %{"season" => season}) do
    episodes_watched = UsersEpisode |> Ecto.Query.where(user_id: ^user.id) |> Repo.all
    |> Enum.map(fn(x) -> x.episode_id end)
    follow = Repo.get_by(UsersShow, user_id: user.id, show_id: show.id)
    episodes = Repo.all(from e in Episode, where: e.show_id == ^show.id and e.season == ^season, order_by: [e.season, e.number])
    |> Repo.preload(:show)
    render(conn, "index.html", episodes: episodes, show: show, episodes_watched: episodes_watched, follow: follow)
  end

  def new(%{assigns: %{show: show}} = conn, _params) do
    changeset = Episode.changeset(%Episode{})
    render(conn, "new.html", changeset: changeset, show: show)
  end

  def create(%{assigns: %{show: show}} = conn, %{"episode" => episode_params}) do
    changeset = show
    |> build_assoc(:episodes)
    |> Episode.changeset(episode_params)
    case Repo.insert(changeset) do
      {:ok, _episode} ->
        conn
        |> redirect(to: show_episode_path(conn, :index, show))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    episode = Repo.get!(Episode, id)
    render(conn, "show.html", episode: episode)
  end

  def edit(%{assigns: %{show: show}} = conn, %{"id" => id}) do
    episode = Repo.get!(Episode, id)
    changeset = Episode.changeset(episode)
    render(conn, "edit.html", episode: episode, changeset: changeset, show: show)
  end

  def update(conn, %{"id" => id, "episode" => episode_params}) do
    episode = Repo.get!(Episode, id)
    changeset = Episode.changeset(episode, episode_params)

    case Repo.update(changeset) do
      {:ok, episode} ->
        conn
        |> redirect(to: show_episode_path(conn, :show, episode))
      {:error, changeset} ->
        render(conn, "edit.html", episode: episode, changeset: changeset)
    end
  end

  def delete(%{assigns: %{show: show}} = conn, %{"id" => id}) do
    episode = Repo.get!(Episode, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(episode)

    conn
    |> redirect(to: show_episode_path(conn, :index, show))
  end

  # /shows/:id/episodes/:id/watch
  def watch(%{assigns: %{user: user}} = conn, %{"episode_id" => episode_id, "show_id" => show_id}) do
    episode = Repo.get!(Episode, episode_id)
    changeset = UsersEpisode.changeset(%UsersEpisode{}, %{user_id: user.id, episode_id: episode_id})
    case Repo.insert(changeset) do
      {:ok, _episode} ->
        conn
        |> put_status(200)
        |> json(%{ message: "Episode watched!" })
      {:error, _changeset} ->
        conn
        |> put_status(400)
        |> json(%{ message: "Episode nitwatched!" })
    end
  end

  # /shows/:id/episodes/:id/unwatch
  def unwatch(%{assigns: %{user: user}} = conn, %{"episode_id" => episode_id, "show_id" => show_id}) do
    episode = Repo.get!(Episode, episode_id)
    user_episode = Repo.get_by!(UsersEpisode, user_id: user.id, episode_id: episode_id)

    Repo.delete!(user_episode)
    conn
    |> put_status(200)
    |> json(%{ message: "Episode unwatched!" })
  end

  defp set_show(%{params: %{"show_id" => show_id}} = conn, _) do
    show = Repo.get(Show, show_id)
    assign(conn, :show, show)
  end
end
