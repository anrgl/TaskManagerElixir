defmodule TaskManager.TagFactory do
  defmacro __using__(_opts) do
    quote do
      alias TaskManager.Tags.Tag

      def tag_factory do
        %Tag{
          name: Faker.Pokemon.name()
        }
      end
    end
  end
end
