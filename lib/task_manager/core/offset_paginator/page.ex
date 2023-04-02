defmodule TaskManager.Core.OffsetPaginator.Page do
  defstruct [:entries, :metadata]

  alias TaskManager.Core.OffsetPaginator.Metadata

  def new(entries, page_number, page_size, total_pages, total_count) do
    %__MODULE__{
      entries: entries,
      metadata: Metadata.new(page_number, page_size, total_pages, total_count)
    }
  end
end
