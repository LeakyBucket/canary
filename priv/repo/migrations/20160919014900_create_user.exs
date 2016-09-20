defmodule Canary.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :email, :string
      add :account_id, references(:accounts, type: :uuid, on_delete: :nothing)

      timestamps()
    end
    create index(:users, [:account_id])

  end
end
