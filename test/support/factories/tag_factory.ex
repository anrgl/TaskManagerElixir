defmodule TaskManager.TagFactory do
  defmacro __using__(_opts) do
    quote do
      use ExMachina.Ecto, repo: TaskManager.Repo
      alias TaskManager.Tags.Tag

      def tag_factory do
        %Tag{
          name: Faker.Pokemon.name()
        }
      end
    end
  end
end
