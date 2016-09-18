defmodule Canary.Repo.Migrations.CreateTestStep do
  use Ecto.Migration

  def change do
    create table(:tests_steps, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :position, :integer, null: false
      add :step_id, references(:steps, type: :uuid), null: false
      add :test_id, references(:tests, type: :uuid), null: false

      timestamps()
    end

  end
end
