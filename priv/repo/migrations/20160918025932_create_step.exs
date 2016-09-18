defmodule Canary.Repo.Migrations.CreateStep do
  use Ecto.Migration

  def change do
    create table(:steps, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :actions, {:array, :map}

      timestamps()
    end

  end
end
