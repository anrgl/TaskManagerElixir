defmodule TaskManager.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskManager.Users.User

  schema "tasks" do
    field :description, :string
    field :end_task_date, :date
    field :priority, :string
    field :state, :string
    field :title, :string
    belongs_to :creator, User
    belongs_to :performer, User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :end_task_date, :state, :priority])
    |> validate_required([:title, :description, :end_task_date, :state, :priority])
  end
end
