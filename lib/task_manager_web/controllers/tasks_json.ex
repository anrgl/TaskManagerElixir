defmodule TaskManagerWeb.TasksJSON do
  alias TaskManager.Tasks.Task

  def index(%{tasks: tasks}) do
    %{data: for(task <- tasks, do: data(task))}
  end

  def show(%{task: task}) do
    %{data: data(task)}
  end

  defp data(%Task{} = task) do
    %{
      id: task.id,
      title: task.title,
      description: task.description,
      priority: task.priority,
      state: task.state,
      end_task_date: task.end_task_date,
      creator_id: task.creator_id,
      performer_id: task.performer_id
    }
  end
end
