defmodule TaskManagerWeb.ApiDoc.TaskDoc do
  use PhoenixSwagger

  alias TaskManagerWeb.ApiDoc.{BaseSchemas, CommonParameters}

  @end_task_date Date.utc_today() |> Date.end_of_week()

  defmacro __using__(_) do
    quote do
      use PhoenixSwagger
      alias PhoenixSwagger.Path

      defdelegate swagger_definitions,
        to: TaskManagerWeb.ApiDoc.TaskDoc,
        as: :swagger_definitions

      swagger_path :index do
        get("/api/tasks")
        consumes("application/json")
        produces("application/json")
        CommonParameters.pagination()
        response(200, "OK", Schema.ref(:Tasks))
      end

      swagger_path :create do
        post("/api/tasks")
        consumes("application/json")
        produces("application/json")

        parameters do
          task(:body, Schema.ref(:TaskBody), "Task attributes")
        end

        response(201, "OK", Schema.ref(:Task))
      end

      swagger_path :show do
        get("/api/tasks/{id}")
        consumes("application/json")
        produces("application/json")

        parameters do
          id(:path, :integer, "Task id", required: true)
        end

        response(200, "OK", Schema.ref(:Task))
      end

      swagger_path :update do
        patch("/api/tasks/{id}")
        consumes("application/json")
        produces("application/json")

        parameters do
          id(:path, :integer, "Task id", required: true)
          task(:body, Schema.ref(:TaskBody), "Task attributes")
        end

        response(200, "OK", Schema.ref(:Task))
      end

      swagger_path :delete do
        Path.delete("/api/tasks/{id}")
        consumes("application/json")
        produces("application/json")

        parameters do
          id(:path, :integer, "Task id", required: true)
        end

        response(204, "OK")
      end
    end
  end

  def swagger_definitions do
    %{
      TaskSchema:
        swagger_schema do
          title("Task")
          description("Task entity")

          properties do
            id(:string, "Unique identifier", required: true)
            title(:string, "Task title", required: true)
            description(:string, "Task description", required: true)
            end_task_date(:date, "Task end date", required: true)
            priority(:string, "Task priority", required: true)
            state(:string, "Task state", required: true)
            creator_id(:integer, "Task creator id")
            performer_id(:integer, "Task performer id")
          end

          example(%{
            id: 1,
            title: "Task #1",
            description: "Task description",
            end_task_date: @end_task_date,
            priority: "LOW",
            state: "NEW_TASK",
            creator_id: 1,
            performer_id: 2
          })
        end,
      TaskBody:
        swagger_schema do
          title("Task")
          description("Task entity")

          properties do
            task(
              Schema.new do
                properties do
                  title(:string, "Task title", required: true)
                  description(:string, "Task description", required: true)
                  end_task_date(:date, "Task end date", required: true)
                  priority(:string, "Task priority", required: true)
                  state(:string, "Task state", required: true)
                  creator_id(:integer, "Task creator id")
                  performer_id(:integer, "Task performer id")
                end

                example(%{
                  email: "ainur.galimov@examplepartners.com",
                  title: "Task #1",
                  description: "Task description",
                  end_task_date: @end_task_date,
                  priority: "LOW",
                  state: "NEW_TASK",
                  creator_id: 1,
                  performer_id: 2
                })
              end
            )
          end
        end,
      Task: BaseSchemas.single_resource(:TaskSchema, "Task"),
      Tasks: BaseSchemas.list_resource(:TaskSchema, "Tasks")
    }
  end
end
