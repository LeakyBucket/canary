defmodule Canary.Test do
  use Canary.Web, :model

  schema "tests" do
    field :name, :string
    many_to_many :steps, Canary.Step, join_through: Canary.TestStep

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
