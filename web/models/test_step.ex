defmodule Canary.TestStep do
  use Canary.Web, :model

  schema "tests_steps" do
    field :position, :integer, null: false
    belongs_to :step, Canary.Step, type: Ecto.UUID
    belongs_to :test, Canary.Test, type: Ecto.UUID

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:position])
    |> validate_required([:position])
  end
end
