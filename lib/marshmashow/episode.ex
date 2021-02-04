defmodule Marshmashow.Episode do
  use Ecto.Schema
import Ecto.Changeset

  schema "episodes" do
    field :title, :string
    field :synopsys, :string
    field :season, :integer
    field :number, :integer
    field :duration, :integer
    field :released, :naive_datetime

    belongs_to(:show, Marshmashow.Show)
    many_to_many(:users, Marshmashow.User, join_through: "users_episodes")
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :synopsys, :season, :number, :released, :show_id, :duration])
    |> validate_required([:title, :synopsys, :season, :number, :released, :show_id, :duration])
  end
end
