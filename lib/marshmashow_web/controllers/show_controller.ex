defmodule MarshmashowWeb.ShowController do
  use MarshmashowWeb, :controller

  alias Marshmashow.Show
  alias Marshmashow.UsersShow
  alias Marshmashow.Episode
  alias Marshmashow.UsersEpisode

  plug MarshmashowWeb.Plugs.RequireAuth
  # plug(:set_user when action in [:index, :follow])

  def index(%{assigns: %{user: user}} = conn, _params) do
    followed = UsersShow |> Ecto.Query.where(user_id: ^user.id) |> Repo.all
    |> Enum.map(fn(x) -> x.show_id end)
    shows = Repo.all(from x in Show, order_by: [asc: x.id], limit: 50)
    render(conn, "index.html", shows: shows, followed: followed)
  end

  def new(conn, _params) do
    changeset = Show.changeset(%Show{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"show" => show_params}) do
    changeset = Show.changeset(%Show{}, show_params)

    case Repo.insert(changeset) do
      {:ok, _show} ->
        conn
        |> redirect(to: show_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

def show(%{assigns: %{user: user}} = conn, %{"id" => id}) do
    show = Repo.get!(Show, id)
    seasons = Repo.all(from e in Episode, where: e.show_id == ^show.id, order_by: [e.season, e.number])
    |> Repo.preload(:show)
    |> Enum.chunk_by(fn %{season: season} -> season end)
    episodes_watched = UsersEpisode |> Ecto.Query.where(user_id: ^user.id) |> Repo.all
    |> Enum.map(fn(x) -> x.episode_id end)
    follow = Repo.get_by(UsersShow, user_id: user.id, show_id: show.id)
    render(conn, "show.html", show: show, seasons: seasons, follow: follow, episodes_watched: episodes_watched)
  end

  def edit(conn, %{"id" => id}) do
    show = Repo.get!(Show, id)
    changeset = Show.changeset(show)
    render(conn, "edit.html", show: show, changeset: changeset)
  end

  def update(conn, %{"id" => id, "show" => show_params}) do
    show = Repo.get!(Show, id)
    changeset = Show.changeset(show, show_params)

    case Repo.update(changeset) do
      {:ok, show} ->
        conn
        |> redirect(to: show_path(conn, :show, show))
      {:error, changeset} ->
        render(conn, "edit.html", show: show, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    show = Repo.get!(Show, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(show)

    conn
    |> redirect(to: show_path(conn, :index))
  end

  def follow(%{assigns: %{user:  user}} = conn, %{"show_id" => show_id}) do
    changeset = UsersShow.changeset(%UsersShow{}, %{user_id: user.id, show_id: show_id})
    Repo.insert(changeset)
    conn
    |> redirect_back(default: "/")
    # |> redirect(to: show_episode_path(conn, :index, show_id))
  end

  def unfollow(%{assigns: %{user:  user}} = conn, %{"show_id" => show_id}) do
    user_show = Repo.get_by!(UsersShow, show_id: show_id, user_id: user.id)

    Repo.delete!(user_show)
    conn
    |> redirect_back(default: "/")
    # |> redirect(to: show_episode_path(conn, :index, show_id))
  end

  def search(conn, %{"search" => %{"title" => title}}) do
    shows = Repo.all(from p in Show, where: ilike(p.title, ^("%#{title}%")))
    render(conn, "search.html", shows: shows, search: title)
  end

  def fill_in(_conn, _params) do
    shows = Repo.all(Show)
    shows = Repo.preload shows, :episodes

    Enum.map_every(shows, 1, fn(show) ->
      tvmaze_episodes = TvmazeWrapper.Shows.get_episodes(show.tvmaze)
      number_tvmaze_episodes = Enum.count(tvmaze_episodes)

      number_episodes = Enum.count(show.episodes)
      if number_episodes != number_tvmaze_episodes do
        Enum.map(tvmaze_episodes, fn(episode) ->
          episode_db = Episode |> Ecto.Query.where(show_id: ^show.id, number: ^episode["number"], season: ^episode["season"]) |> Repo.all
          if episode_db == [] do
            changeset = Episode.changeset(%Episode{}, %{
              title: episode["name"],
              synopsys: episode["summary"],
              duration: episode["runtime"],
              number: episode["number"],
              season: episode["season"],
              show_id: show.id,
              released: episode["airdate"]})

              Repo.insert(changeset)
          end
        end)
      end
    end)
  end

  def check(_conn, _params) do
    # shows = Repo.all(Show)
    # shows = Repo.preload shows, :episodes
    # Enum.map(shows, fn(show) ->
    # end)
    shows = Repo.all(Show)
    shows = Repo.preload shows, :episodes
    Enum.map(shows, fn(show) ->
      others_show = Show |> Ecto.Query.where(title: ^show.title) |> Repo.all
      if Enum.count(others_show) > 1 do
        # IO.puts "-------------------------"
        # IO.inspect(others_show)
        # IO.puts "-------------------------"
        Repo.delete!(show)
      end
      # if Enum.count(show.episodes) == 0 do
        # Repo.delete!(show)
      # end
    end)
  end

  # def fill_in(conn, _params) do
  #   shows = Repo.all(Show)
  #   Enum.map(shows, fn(show) ->
  #     if show.image == nil do
  #       tvmaze_show = TvmazeWrapper.Shows.get_show(show.tvmaze)
  #       if tvmaze_show.image != nil do
  #         Marshmashow.ImageUploader.store(tvmaze_show.image)
  #         link_splitted = String.split(tvmaze_show.image, "/")
  #         link = Enum.at(link_splitted, Enum.count(link_splitted) - 1)
  #         changeset = Show.changeset(show, %{"image" => link, "synopsys" => tvmaze_show.summary})
  #         Repo.update(changeset)
  #       end
  #     end
  #   end)
  # end

  # defp set_user(conn, _) do
  #     user = Repo.get(User, get_session(conn, :user_id))
  #     assign(conn, :user, user)
  # end
  defp redirect_back(conn, opts \\ []) do
    Phoenix.Controller.redirect(conn, to: NavigationHistory.last_path(conn, opts))
  end
end
