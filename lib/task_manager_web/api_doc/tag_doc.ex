defmodule TaskManagerWeb.ApiDoc.TagDoc do
  use PhoenixSwagger

  alias TaskManagerWeb.ApiDoc.{BaseSchemas, CommonParameters}

  defmacro __using__(_) do
    quote do
      use PhoenixSwagger
      alias PhoenixSwagger.Path

      defdelegate swagger_definitions,
        to: TaskManagerWeb.ApiDoc.TagDoc,
        as: :swagger_definitions

      swagger_path :index do
        get("/api/tags")
        consumes("application/json")
        produces("application/json")
        CommonParameters.pagination()

        parameters do
          name(:query, :string, "Tag name")
        end

        response(200, "OK", Schema.ref(:Tags))
      end

      swagger_path :create do
        post("/api/tags")
        consumes("application/json")
        produces("application/json")

        parameters do
          tag(:body, Schema.ref(:TagBody), "Tag attributes")
        end

        response(201, "OK", Schema.ref(:Tag))
      end

      swagger_path :show do
        get("/api/tags/{id}")
        consumes("application/json")
        produces("application/json")

        parameters do
          id(:path, :integer, "Tag id", required: true)
        end

        response(200, "OK", Schema.ref(:Tag))
      end

      swagger_path :update do
        patch("/api/tags/{id}")
        consumes("application/json")
        produces("application/json")

        parameters do
          id(:path, :integer, "Tag id", required: true)
          tag(:body, Schema.ref(:TagBody), "Tag attributes")
        end

        response(200, "OK", Schema.ref(:Tag))
      end

      swagger_path :delete do
        Path.delete("/api/tags/{id}")
        consumes("application/json")
        produces("application/json")

        parameters do
          id(:path, :integer, "Tag id", required: true)
        end

        response(204, "OK")
      end
    end
  end

  def swagger_definitions do
    %{
      TagSchema:
        swagger_schema do
          title("Tag")
          description("Tag entity")

          properties do
            id(:string, "Unique identifier", required: true)
            name(:string, "Tag name", required: true)
          end

          example(%{
            id: 1,
            name: "Tag #1"
          })
        end,
      TagBody:
        swagger_schema do
          title("Tag")
          description("Tag entity")

          properties do
            tag(
              Schema.new do
                properties do
                  name(:string, "Tag name", required: true)
                end

                example(%{
                  name: "Tag #1"
                })
              end
            )
          end
        end,
      Tag: BaseSchemas.single_resource(:TagSchema, "Tag"),
      Tags: BaseSchemas.list_resource(:TagSchema, "Tags")
    }
  end
end
