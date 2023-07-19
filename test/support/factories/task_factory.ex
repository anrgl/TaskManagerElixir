defmodule TaskManager.TaskFactory do
  defmacro __using__(_opts) do
    quote do
      alias TaskManager.Tasks.{Task, TaskPriority, TaskState}

      def new_task_factory do
        %{task_factory() | state: TaskState.value!(:new_task)}
      end

      def in_development_factory do
        %{task_factory() | state: TaskState.value!(:in_development)}
      end

      def in_qa_factory do
        %{task_factory() | state: TaskState.value!(:in_qa)}
      end

      def in_code_review_factory do
        %{task_factory() | state: TaskState.value!(:in_code_review)}
      end

      def ready_for_release_factory do
        %{task_factory() | state: TaskState.value!(:ready_for_release)}
      end

      def released_factory do
        %{task_factory() | state: TaskState.value!(:released)}
      end

      def archived_factory do
        %{task_factory() | state: TaskState.value!(:archived)}
      end

      defp task_factory do
        %Task{
          title: Faker.Pokemon.name(),
          description: Faker.String.naughty(),
          end_task_date: Faker.Date.forward(1),
          priority: TaskPriority.value!(:low),
          state: nil,
          creator: insert(:manager),
          performer: insert(:developer),
          tags: []
        }
      end
    end
  end
end
