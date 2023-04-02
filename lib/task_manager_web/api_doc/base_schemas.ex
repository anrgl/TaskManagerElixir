defmodule TaskManagerWeb.ApiDoc.BaseSchemas do
  use PhoenixSwagger

  def single_resource(resource_atom, resource_name) do
    swagger_schema do
      title(resource_name)
      description("Single #{resource_name} resource")

      properties do
        data(Schema.ref(resource_atom), "#{resource_name} resource")
      end
    end
  end

  def list_resource(resource_atom, resource_name) do
    swagger_schema do
      title(resource_name)
      description("A collection of #{resource_name}")

      properties do
        data(array(resource_atom), "#{resource_name} collection")

        pagination(
          Schema.new do
            properties do
              total_pages(:integer, "Total pages count")
              page_size(:integer, "Current page size")
              page_number(:integer, "Current page number")
              total_count(:integer, "Total entries count")
            end

            example(%{
              total_pages: 7,
              page_size: 10,
              page_number: 2,
              total_count: 70
            })
          end
        )
      end
    end
  end
end
