defmodule Marshmashow.Show do
  @moduledoc """
  Show model
  """
  use Ecto.Schema
import Ecto.Changeset

  schema "shows" do
    field :title, :string
    field :tvmaze, :string
    field :network, :string
    field :country, :string
    field :synopsys, :string
    field :start_date, :string
    field :end_date, :string
    field :number_of_episodes, :string
    field :run_time, :string
    # field :image, Marshmashow.ImageUploader.Type
    field :image, :string
    field :status, :string
    field :premiered, :date

    has_many(:episodes, Marshmashow.Episode, on_delete: :delete_all)
    many_to_many(:users, Marshmashow.User, join_through: "users_shows")
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :synopsys, :image, :tvmaze,
                    :network, :country, :start_date, :end_date,
                    :number_of_episodes, :run_time, :status, :premiered])
    |> validate_required([:title, :synopsys, :image, :tvmaze,
                    :network, :country, :start_date, :end_date,
                    :number_of_episodes, :run_time, :status, :premiered])
  end
end
