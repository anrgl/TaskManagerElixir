defmodule TaskManager.TasksTest do
  use TaskManager.DataCase
  use TaskManager.TaskFactory

  alias TaskManager.Tasks
  alias TaskManager.Tasks.Task

  @moduletag :tasks_test

  describe "tasks" do
    @invalid_attrs %{description: nil, end_task_date: nil, priority: nil, state: nil, title: nil}

    test "list_tasks/0 returns all tasks" do
      insert(:new_task)
      assert Tasks.list_tasks() != []
    end

    test "get_task!/1 returns the task with given id" do
      task = insert(:new_task)
      assert Tasks.get_task!(task.id).id == task.id
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = params_for(:new_task)

      assert {:ok, %Task{} = task} = Tasks.create_task(valid_attrs)
      assert task.description == valid_attrs.description
      assert task.end_task_date == valid_attrs.end_task_date
      assert task.priority == TaskPriority.value!(:low)
      assert task.state == TaskState.value!(:new_task)
      assert task.title == valid_attrs.title
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = insert(:new_task)

      update_attrs = params_for(:in_development)

      assert {:ok, %Task{} = task} = Tasks.update_task(task, update_attrs)
      assert task.description == update_attrs.description
      assert task.end_task_date == update_attrs.end_task_date
      assert task.priority == TaskPriority.value!(:low)
      assert task.state == TaskState.value!(:in_development)
      assert task.title == update_attrs.title
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = insert(:new_task)
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task.id == Tasks.get_task!(task.id).id
    end

    test "delete_task/1 deletes the task" do
      task = insert(:new_task)
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = insert(:new_task)
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
