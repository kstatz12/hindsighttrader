defmodule Hindsight.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
