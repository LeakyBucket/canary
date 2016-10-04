defmodule Canary.TestRunControllerTest do
  use Canary.ConnCase

  alias Canary.TestRun
  @valid_attrs %{metrics: %{}, result: true}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, test_run_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    test_run = Repo.insert! %TestRun{}
    conn = get conn, test_run_path(conn, :show, test_run)
    assert json_response(conn, 200)["data"] == %{"id" => test_run.id,
      "test_id" => test_run.test_id,
      "user_id" => test_run.user_id,
      "result" => test_run.result,
      "metrics" => test_run.metrics}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, test_run_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, test_run_path(conn, :create), test_run: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(TestRun, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, test_run_path(conn, :create), test_run: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    test_run = Repo.insert! %TestRun{}
    conn = put conn, test_run_path(conn, :update, test_run), test_run: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(TestRun, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    test_run = Repo.insert! %TestRun{}
    conn = put conn, test_run_path(conn, :update, test_run), test_run: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    test_run = Repo.insert! %TestRun{}
    conn = delete conn, test_run_path(conn, :delete, test_run)
    assert response(conn, 204)
    refute Repo.get(TestRun, test_run.id)
  end
end
