defmodule Marshmashow.UsersShow do
  @moduledoc """
    Make the relationship with Users and Shows append
    Many-To-Many
    Many Users can follow many of Shows
    Many Shows can be followed by Many of Users
  """
  use Ecto.Schema
import Ecto.Changeset

  schema "users_shows" do
    timestamps()
    belongs_to(:user, Marshmashow.User)
    belongs_to(:show, Marshmashow.Show)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :show_id])
    |> validate_required([:user_id, :show_id])
  end
end
