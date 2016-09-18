defmodule Canary.TestStep do
  use Canary.Web, :model

  schema "tests_steps" do
    field :position, :integer
    belongs_to :steps, Canary.Step
    belongs_to :tests, Canary.Test

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
