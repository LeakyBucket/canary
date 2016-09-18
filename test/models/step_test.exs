defmodule Canary.StepTest do
  use Canary.ModelCase

  alias Canary.Step

  @valid_attrs %{actions: %{}, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Step.changeset(%Step{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Step.changeset(%Step{}, @invalid_attrs)
    refute changeset.valid?
  end
end
