defmodule TaskManagerWeb.PaginationJSON do
  def render(%{pagination: pagination}) do
    %{
      page_number: pagination.page_number,
      page_size: pagination.page_size,
      total_pages: pagination.total_pages,
      total_count: pagination.total_count
    }
  end
end
