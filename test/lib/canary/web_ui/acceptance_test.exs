defmodule Canary.WebUI.AcceptanceTest do
  use ExUnit.Case
  alias Canary.WebUI.Acceptance

  @positive %Acceptance{type: :is, target: {:id, "body"}, value: "match"}
  @negative %Acceptance{type: :is_not, target: {:id, "body"}, value: "match"}

  test "positive assertion to string" do
    expected = "String.contains?(inner_html({:id, \"body\"}), \"match\")"

    assert ^expected = Acceptance.houndify(@positive)
  end

  test "negative assertion to string" do
    expected = "!String.contains?(inner_html({:id, \"body\"}), \"match\")"

    assert ^expected = Acceptance.houndify(@negative)
  end
end
