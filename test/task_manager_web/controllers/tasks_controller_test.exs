defmodule TaskManagerWeb.TasksControllerTest do
  use TaskManagerWeb.ConnCase
  use TaskManager.TaskFactory

  alias TaskManager.Tasks.Task

  @invalid_attrs %{title: nil, description: nil, end_task_date: nil}
  @moduletag :task_controller

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      insert(:new_task)
      conn = get(conn, ~p"/api/tasks")
      assert json_response(conn, 200)["data"] != []
    end

    test "filter by title", %{conn: conn} do
      title = "test_task_title"

      insert(:new_task, %{title: title})
      insert(:new_task)

      conn = get(conn, ~p"/api/tasks", title: title)

      assert [task] = json_response(conn, 200)["data"]
      assert task["title"] == title
    end
  end

  describe "create task" do
    test "renders task when data is valid", %{conn: conn} do
      task_params = params_for(:new_task)

      conn = post(conn, ~p"/api/tasks", task: task_params)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/tasks/#{id}")
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/tasks", task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update task" do
    setup [:create_task]

    test "renders task when data is valid", %{conn: conn, task: %Task{id: id} = task} do
      update_attrs = params_for(:new_task)

      conn = put(conn, ~p"/api/tasks/#{task}", task: update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/tasks/#{id}")

      title = update_attrs.title

      assert %{
               "id" => ^id,
               "title" => ^title
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, task: task} do
      conn = put(conn, ~p"/api/tasks/#{task}", task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "delete chosen task", %{conn: conn, task: task} do
      conn = delete(conn, ~p"/api/tasks/#{task}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/tasks/#{task}")
      end
    end
  end

  defp create_task(_) do
    task = insert(:new_task)
    %{task: task}
  end
end
