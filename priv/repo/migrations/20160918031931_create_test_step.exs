defmodule Canary.Repo.Migrations.CreateTestStep do
  use Ecto.Migration

  def change do
    create table(:tests_steps) do
      add :position, :integer, null: false
      add :step_id, references(:steps), null: false
      add :test_id, references(:tests), null: false

      timestamps()
    end

  end
end
