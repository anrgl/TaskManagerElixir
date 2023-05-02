defmodule TaskManagerWeb.ApiDoc.CurrentUserDoc do
  use PhoenixSwagger

  alias TaskManagerWeb.ApiDoc.BaseSchemas

  defmacro __using__(_) do
    quote do
      use PhoenixSwagger
      alias PhoenixSwagger.Path

      defdelegate swagger_defintitions,
        to: TaskManagerWeb.ApiDoc.CurrentUserDoc,
        as: :swagger_definitions

      swagger_path :show do
        get("/api/user")
        consumes("application/json")
        produces("application/json")

        response(200, "OK", Schema.ref(:User))
      end
    end
  end

  def swagger_definitions do
    %{
      CurrentUserSchema:
        swagger_schema do
          title("Current User")
          description("Current User entity")

          properties do
            id(:string, "Unique identifier", required: true)
            first_name(:string, "User first name", required: true)
            last_name(:string, "User last name", required: true)
            email(:string, "User email", required: true)
            role(:string, "User role", required: true)
          end

          example(%{
            data: %{
              id: 1,
              email: "ainur.galimov@examplepartners.com",
              first_name: "Ainur",
              last_name: "Galimov",
              role: "DEVELOPER"
            }
          })
        end,
      CurrentUserBody:
        swagger_schema do
          title("Current User")
          description("Current User entity")

          properties do
            user(
              Schema.new do
                properties do
                  first_name(:string, "User first name", required: true)
                  last_name(:string, "User last name", required: true)
                  email(:string, "User email", required: true)
                  role(:string, "User role", required: true)
                end

                example(%{
                  data: %{
                    id: 1,
                    email: "ainur.galimov@examplepartners.com",
                    first_name: "Ainur",
                    last_name: "Galimov",
                    role: "DEVELOPER"
                  }
                })
              end
            )
          end
        end,
      CurrentUser: BaseSchemas.single_resource(:CurrentUserSchema, "CurrentUser")
    }
  end
end
