defmodule Marshmashow.Repo.Migrations.AddUsersShows do
  use Ecto.Migration

  def change do
    create table(:users_shows) do
      add(:user_id, references(:users))
      add(:show_id, references(:shows))

      timestamps()
    end
  end
end
