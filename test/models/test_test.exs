defmodule Canary.TestTest do
  use Canary.ModelCase

  alias Canary.Test

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Test.changeset(%Test{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Test.changeset(%Test{}, @invalid_attrs)
    refute changeset.valid?
  end
end
