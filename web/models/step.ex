defmodule Canary.Step do
  use Canary.Web, :model

  schema "steps" do
    field :name, :string
    field :actions, :map
    many_to_many :tests, Canary.Test, join_through: Canary.TestStep

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :actions])
    |> validate_required([:name, :actions])
  end
end
