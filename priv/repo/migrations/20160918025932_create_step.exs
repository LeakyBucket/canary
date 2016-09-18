defmodule Canary.Repo.Migrations.CreateStep do
  use Ecto.Migration

  def change do
    create table(:steps) do
      add :name, :string
      add :actions, :map

      timestamps()
    end

  end
end
