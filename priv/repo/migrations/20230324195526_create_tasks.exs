defmodule TaskManager.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :string
      add :end_task_date, :date
      add :state, :string
      add :priority, :string
      add :creator_id, references(:users, on_delete: :nothing)
      add :performer_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:creator_id])
    create index(:tasks, [:performer_id])
  end
end
