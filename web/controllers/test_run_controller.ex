defmodule Canary.TestRunController do
  use Canary.Web, :controller

  alias Canary.TestRun

  def index(conn, _params) do
    test_runs = Repo.all(TestRun)
    render(conn, "index.json", test_runs: test_runs)
  end

  def create(conn, %{"test_run" => test_run_params}) do
    changeset = TestRun.changeset(%TestRun{}, test_run_params)

    case Repo.insert(changeset) do
      {:ok, test_run} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", test_run_path(conn, :show, test_run))
        |> render("show.json", test_run: test_run)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Canary.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    test_run = Repo.get!(TestRun, id)
    render(conn, "show.json", test_run: test_run)
  end

  def update(conn, %{"id" => id, "test_run" => test_run_params}) do
    test_run = Repo.get!(TestRun, id)
    changeset = TestRun.changeset(test_run, test_run_params)

    case Repo.update(changeset) do
      {:ok, test_run} ->
        render(conn, "show.json", test_run: test_run)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Canary.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    test_run = Repo.get!(TestRun, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(test_run)

    send_resp(conn, :no_content, "")
  end
end
