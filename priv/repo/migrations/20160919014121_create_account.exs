defmodule Canary.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end
