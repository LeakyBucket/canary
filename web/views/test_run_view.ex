defmodule Canary.TestRunView do
  use Canary.Web, :view

  def render("index.json", %{test_runs: test_runs}) do
    %{data: render_many(test_runs, Canary.TestRunView, "test_run.json")}
  end

  def render("show.json", %{test_run: test_run}) do
    %{data: render_one(test_run, Canary.TestRunView, "test_run.json")}
  end

  def render("test_run.json", %{test_run: test_run}) do
    %{id: test_run.id,
      test_id: test_run.test_id,
      user_id: test_run.user_id,
      result: test_run.result,
      metrics: test_run.metrics}
  end
end
