defmodule TaskManager.Tags.TaskTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks_tags" do
    field :task_id, :id
    field :tag_id, :id
  end

  @doc false
  def changeset(task_tag, attrs) do
    task_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
