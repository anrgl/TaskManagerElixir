defmodule TaskManager.Notifiers.UserNotifier do
  use Phoenix.Swoosh,
    view: TaskManagerWeb.UserNotifierView,
    layout: {TaskManagerWeb.LayoutView, :email}

  alias TaskManager.Tasks.Task

  def notification(%Task{} = task) do
    new()
    |> from(get_email_from())
    |> to(task.performer.email)
    |> subject("You've assigned a task.")
    |> render_body("notification.html", %{task: task})
  end

  defp get_email_from, do: Application.get_env(:task_manager, :mailer)[:email_from]
end
