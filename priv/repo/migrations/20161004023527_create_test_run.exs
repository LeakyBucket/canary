defmodule Canary.Repo.Migrations.CreateTestRun do
  use Ecto.Migration

  def change do
    create table(:test_runs, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :result, :boolean, default: false, null: false
      add :metrics, :map
      add :test_id, references(:tests, type: :uuid, on_delete: :nothing), null: false
      add :user_id, references(:users, type: :uuid, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:test_runs, [:test_id])
    create index(:test_runs, [:user_id])

  end
end
