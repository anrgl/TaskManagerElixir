defmodule TaskManagerWeb.ApiDoc.CommonParameters do
  import PhoenixSwagger.Path

  def pagination(path) do
    paging(path, size: "page_size", number: "page_number")
  end
end
