defmodule Canary.TestStepTest do
  use Canary.ModelCase

  alias Canary.TestStep

  @valid_attrs %{position: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TestStep.changeset(%TestStep{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TestStep.changeset(%TestStep{}, @invalid_attrs)
    refute changeset.valid?
  end
end
