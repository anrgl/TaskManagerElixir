defmodule TaskManagerWeb.ApiDoc.Info do
  def swagger_info do
    %{
      schemes: schemes(Application.fetch_env!(:task_manager, :env)),
      info: %{
        version: "1.0",
        title: "TaskManager API",
        description: "API Documentation for TaskManager v1",
        termsOfService: "Open for public",
        contact: %{
          name: "Ainur Galimov",
          email: "ainur.galimov@examplepartners.com"
        }
      },
      consumes: ["application/json"],
      produces: ["application/json"]
    }
  end

  def schemes(env) when env in [:test, :dev], do: ["http"]
  def schemes(_), do: ["https"]
end
