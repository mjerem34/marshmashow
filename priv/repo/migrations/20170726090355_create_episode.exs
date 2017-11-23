defmodule Marshmashow.Repo.Migrations.CreateEpisode do
  use Ecto.Migration

  def change do
    create table(:episodes) do
      add :title, :string
      add :synopsys, :text
      add :season, :integer
      add :number, :integer
      add :released, :date
      add :duration, :integer
      add :show_id, references(:shows)
    end
  end
end
