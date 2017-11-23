defmodule Marshmashow.Repo.Migrations.CreateShow do
  use Ecto.Migration

  def change do
    create table(:shows) do
      add :title, :string
      add :synopsys, :text
      add :tvmaze, :string
      add :start_date, :string
      add :end_date, :string
      add :number_of_episodes, :string
      add :run_time, :string
      add :network, :string
      add :country, :string
      add :image, :string
      add :status, :integer
      add :premiered, :date
    end
  end
end
