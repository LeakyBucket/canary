defmodule Canary.WebUI.StepTest do
  use ExUnit.Case
  alias Canary.WebUI.Step
  alias Canary.WebUI.Action

  @fill_username %Action{action: :fill, target: {:id, "user"}, data: "Me"}
  @fill_password %Action{action: :fill, target: {:id, "pass"}, data: "Password"}
  @submit_login %Action{action: :submit, target: {:id, "pass"}}
  @step %Step{name: "Login", actions: [@fill_username, @fill_password, @submit_login]}

  test "action translation" do
    expected = """
    fill_field({:id, "user"}, "Me")
        fill_field({:id, "pass"}, "Password")
        submit_element({:id, "pass"})
    """ |> String.strip

    assert ^expected = Step.translate_actions(@step)
  end

  test "step persistence to file" do
    Application.put_env(:canary, :persist_strategy, Canary.Storage.Filesystem)

    assert {:ok, _} = Step.finalize(@step)
  end

  test "building from file" do
    Application.put_env(:canary, :persist_strategy, Canary.Storage.Filesystem)

    assert @step = Step.load("Login")
  end

  test "listing available steps" do
    assert ["Login"] = Step.available_steps
  end
end
