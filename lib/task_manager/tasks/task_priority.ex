defmodule TaskManager.Tasks.TaskPriority do
  @moduledoc """
  Ecto type for Task Priority
  """

  use TaskManager.Core.UpcaseInclusionString

  @impl true
  def value_map do
    %{
      low: "LOW",
      medium: "MEDIUM",
      high: "HIGH"
    }
  end
end
