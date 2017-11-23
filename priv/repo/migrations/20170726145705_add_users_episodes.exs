defmodule Marshmashow.Repo.Migrations.AddUsersEpisodes do
  use Ecto.Migration

  def change do
    create table(:users_episodes) do
      add(:user_id, references(:users))
      add(:episode_id, references(:episodes))
      
      timestamps()
    end
  end
end
