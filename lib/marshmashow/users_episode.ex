defmodule Marshmashow.UsersEpisode do
  @moduledoc """
    Make the relationship with Users and Episodes append
    Many-To-Many
    Many Users can watch multiples Episodes
    Many Episodes can be watched by multiples Users
  """
  use Ecto.Schema
import Ecto.Changeset

  schema "users_episodes" do
    belongs_to(:user, Marshmashow.User)
    belongs_to(:episode, Marshmashow.Episode)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :episode_id])
    |> validate_required([:user_id, :episode_id])
  end
end
