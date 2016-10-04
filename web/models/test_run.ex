defmodule Canary.TestRun do
  use Canary.Web, :model

  schema "test_runs" do
    field :result, :boolean, default: false
    field :metrics, :map
    belongs_to :test, Canary.Test, type: Ecto.UUID
    belongs_to :user, Canary.User, type: Ecto.UUID

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:result, :metrics])
    |> validate_required([:result, :metrics])
  end
end
