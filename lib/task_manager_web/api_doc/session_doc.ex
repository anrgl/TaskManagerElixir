defmodule TaskManagerWeb.ApiDoc.SessionDoc do
  use PhoenixSwagger

  alias TaskManagerWeb.ApiDoc.{BaseSchemas}

  defmacro __using__(_) do
    quote do
      use PhoenixSwagger
      alias PhoenixSwagger.Path

      defdelegate swagger_definitions,
        to: TaskManagerWeb.ApiDoc.SessionDoc,
        as: :swagger_definitions

      swagger_path :create do
        post("/api/sessions")
        consumes("application/json")
        produces("application/json")

        parameters do
          session(:body, Schema.ref(:SessionBody), "Session attributes")
        end

        response(201, "OK", Schema.ref(:User))
      end

      swagger_path :delete do
        Path.delete("/api/sessions")
        consumes("application/json")
        produces("application/json")

        response(204, "")
      end
    end
  end

  def swagger_definitions do
    %{
      SessionSchema:
        swagger_schema do
          title("Session")
          description("Session entity")

          properties do
            email(:string, "User email", required: true)
            password(:string, "User password", required: true)
          end

          example(%{
            email: "ainur.galimov@examplepartners.com",
            password: "f00barqwertypassword"
          })
        end,
      SessionBody:
        swagger_schema do
          title("Session")
          description("Session entity")

          properties do
            email(:string, "User email", required: true)
            password(:string, "User password", required: true)
          end

          example(%{
            email: "ainur.galimov@examplepartners.com",
            password: "f00barqwertypassword"
          })
        end,
      User: BaseSchemas.single_resource(:UserSchema, "User")
    }
  end
end
