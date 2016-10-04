defmodule Canary.TestRunTest do
  use Canary.ModelCase

  alias Canary.TestRun

  @valid_attrs %{metrics: %{}, result: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TestRun.changeset(%TestRun{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TestRun.changeset(%TestRun{}, @invalid_attrs)
    refute changeset.valid?
  end
end
