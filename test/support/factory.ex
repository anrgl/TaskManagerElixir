defmodule TaskManager.Factory do
  defmacro __using__(_opts) do
    quote do
      use ExMachina.Ecto, repo: TaskManager.Repo
      use TaskManager.UserFactory
      use TaskManager.TaskFactory
      use TaskManager.TagFactory
    end
  end
end
