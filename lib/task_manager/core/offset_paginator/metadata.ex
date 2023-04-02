defmodule TaskManager.Core.OffsetPaginator.Metadata do
  defstruct [:page_number, :page_size, :total_pages, :total_count]

  def new(page_number, page_size, total_pages, total_count) do
    %__MODULE__{
      page_number: page_number,
      page_size: page_size,
      total_pages: total_pages,
      total_count: total_count
    }
  end
end
