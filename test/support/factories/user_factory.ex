defmodule TaskManager.UserFactory do
  defmacro __using__(_opts) do
    quote do
      use ExMachina.Ecto, repo: TaskManager.Repo
      alias TaskManager.Users.{User, UserRole}

      def admin_factory do
        %{user_factory() | role: UserRole.value!(:admin)}
      end

      def developer_factory do
        %{user_factory() | role: UserRole.value!(:developer)}
      end

      def manager_factory do
        %{user_factory() | role: UserRole.value!(:manager)}
      end

      defp user_factory do
        %User{
          email: Faker.Internet.email(),
          first_name: Faker.Person.first_name(),
          last_name: Faker.Person.first_name(),
          password: Faker.String.base64(12),
          role: nil
        }
      end
    end
  end
end
