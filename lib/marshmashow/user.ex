defmodule Marshmashow.User do
  @moduledoc """
  User model
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    # field :provider, :string
    # field :token, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
    many_to_many(:users, Marshmashow.Episode, join_through: "users_episodes")
    many_to_many(:shows, Marshmashow.Show, join_through: "users_shows")
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
    _ ->
      changeset
    end
  end
end
