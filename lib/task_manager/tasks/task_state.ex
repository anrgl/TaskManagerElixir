defmodule TaskManager.Tasks.TaskState do
  @moduledoc """
  Ecto type for Task State
  """

  use TaskManager.Core.UpcaseInclusionString

  @impl
  def value_map do
    %{
      new_task: "NEW_TASK",
      in_development: "IN_DEVELOPMENT",
      in_qa: "IN_QA",
      in_code_review: "IN_CODE_REVIEW",
      ready_for_release: "READY_FOR_RELEASE",
      released: "RELEASED",
      archived: "ARCHIVED"
    }
  end
end
