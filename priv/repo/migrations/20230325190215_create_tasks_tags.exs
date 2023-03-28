defmodule TaskManager.Repo.Migrations.CreateTasksTags do
  use Ecto.Migration

  def change do
    create table(:tasks_tags) do
      add :task_id, references(:tasks, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)
    end

    create index(:tasks_tags, [:task_id])
    create index(:tasks_tags, [:tag_id])
  end
end
