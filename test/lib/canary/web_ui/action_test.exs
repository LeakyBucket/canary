defmodule Canary.WebUI.ActionTest do
  use ExUnit.Case
  alias Canary.WebUI.Action

  test "click step generation" do
    action = %Action{action: :click, target: {:id, "bob"}}

    assert "click({:id, \"bob\"})" = Action.houndify(action)
  end

  test "submit step generation" do
    action = %Action{action: :submit, target: {:id, "form"}}

    assert "submit_element({:id, \"form\"})" = Action.houndify(action)
  end

  test "fill step generation" do
    action = %Action{action: :fill, target: {:id, "username"}, data: "Me"}

    assert "fill_field({:id, \"username\"}, \"Me\")" = Action.houndify(action)
  end

  test "visit step generation" do
    action = %Action{action: :visit, data: "http://a.url"}

    assert "navigate_to(\"http://a.url\")" = Action.houndify(action)
  end
end
