defmodule TaskManager.UserFactory do
  defmacro __using__(_opts) do
    quote do
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
          password: password(),
          hashed_password: hashed_password(),
          role: nil
        }
      end

      defp password, do: Faker.String.base64(12)
      defp hashed_password, do: password() |> Argon2.hash_pwd_salt()
    end
  end
end
