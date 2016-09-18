defmodule Canary.Repo.Migrations.CreateTest do
  use Ecto.Migration

  def change do
    create table(:tests, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end

  end
end
