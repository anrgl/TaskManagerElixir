defmodule TaskManagerWeb.ApiDoc.UserDoc do
  use PhoenixSwagger

  alias TaskManagerWeb.ApiDoc.{BaseSchemas, CommonParameters}

  defmacro __using__(_) do
    quote do
      use PhoenixSwagger
      alias PhoenixSwagger.Path

      defdelegate swagger_definitions,
        to: TaskManagerWeb.ApiDoc.UserDoc,
        as: :swagger_definitions

      swagger_path :index do
        get("/api/users")
        consumes("application/json")
        produces("application/json")
        CommonParameters.pagination()

        parameters do
          full_name(:query, :string, "User full name")
        end

        response(200, "OK", Schema.ref(:Users))
      end

      swagger_path :create do
        post("/api/users")
        consumes("application/json")
        produces("application/json")

        parameters do
          user(:body, Schema.ref(:UserBody), "User attributes")
        end

        response(201, "OK", Schema.ref(:User))
      end

      swagger_path :show do
        get("/api/users/{id}")
        consumes("application/json")
        produces("application/json")

        parameters do
          id(:path, :integer, "User id", required: true)
        end

        response(200, "OK", Schema.ref(:User))
      end

      swagger_path :update do
        patch("/api/users/{id}")
        consumes("application/json")
        produces("application/json")

        parameters do
          id(:path, :integer, "User id", required: true)
          user(:body, Schema.ref(:UserBody), "User attributes")
        end

        response(200, "OK", Schema.ref(:User))
      end

      swagger_path :delete do
        Path.delete("/api/users/{id}")
        consumes("application/json")
        produces("application/json")

        parameters do
          id(:path, :integer, "User id", required: true)
        end

        response(204, "OK")
      end
    end
  end

  def swagger_definitions do
    %{
      UserSchema:
        swagger_schema do
          title("User")
          description("User entity")

          properties do
            id(:string, "Unique identifier", required: true)
            first_name(:string, "User first name", required: true)
            last_name(:string, "User last name", required: true)
            email(:string, "User email", required: true)
            role(:string, "User role", required: true)
          end

          example(%{
            id: 1,
            email: "ainur.galimov@examplepartners.com",
            first_name: "Ainur",
            last_name: "Galimov",
            role: "DEVELOPER"
          })
        end,
      UserBody:
        swagger_schema do
          title("User")
          description("User entity")

          properties do
            user(
              Schema.new do
                properties do
                  first_name(:string, "User first name", required: true)
                  last_name(:string, "User last name", required: true)
                  email(:string, "User email", required: true)
                  role(:string, "User role", required: true)
                  password(:string, "User password", required: true)
                end

                example(%{
                  email: "ainur.galimov@examplepartners.com",
                  first_name: "Ainur",
                  last_name: "Galimov",
                  role: "DEVELOPER",
                  password: "f00bar"
                })
              end
            )
          end
        end,
      User: BaseSchemas.single_resource(:UserSchema, "User"),
      Users: BaseSchemas.list_resource(:UserSchema, "Users")
    }
  end
end
