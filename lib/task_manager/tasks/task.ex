defmodule TaskManager.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskManager.Users.User
  alias TaskManager.Tasks.{TaskPriority, TaskState}

  schema "tasks" do
    field :description, :string
    field :end_task_date, :date
    field :priority, TaskPriority
    field :state, TaskState
    field :title, :string
    belongs_to :creator, User
    belongs_to :performer, User
    many_to_many :tags, TaskManager.Tags.Tag, join_through: "tasks_tags"

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [
      :title,
      :description,
      :end_task_date,
      :state,
      :priority,
      :creator_id,
      :performer_id
    ])
    |> validate_required([:title, :description, :end_task_date, :state, :priority])
    |> foreign_key_constraint(:creator_id)
    |> foreign_key_constraint(:performer_id)
    |> validate_change(:end_task_date, &validate_current_or_future_date/2)
  end

  def validate_current_or_future_date(field_name, %Date{} = end_task_date) do
    end_task_date
    |> Date.compare(Date.utc_today())
    |> case do
      :lt -> [{field_name, "Date in the past"}]
      _ -> []
    end
  end
end
