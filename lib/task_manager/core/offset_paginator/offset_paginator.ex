defmodule TaskManager.Core.OffsetPaginator do
  import Ecto.Query

  alias TaskManager.Core.OffsetPaginator.Page

  defmacro __using__(opts) do
    quote do
      @defaults unquote(opts)

      def paginate(queryable, opts \\ []) do
        opts =
          opts
          |> get_params()
          |> Keyword.merge(@defaults)

        TaskManager.Core.OffsetPaginator.paginate(queryable, opts, __MODULE__)
      end

      defp get_params(%{"page_number" => page_number, "page_size" => page_size}) do
        [
          page_number: maybe_to_int(page_number),
          page_size: maybe_to_int(page_size)
        ]
      end

      defp get_params(%{"page_size" => page_size}) do
        [
          page_size: maybe_to_int(page_size)
        ]
      end

      defp get_params(%{"page_number" => page_number}) do
        [
          page_number: maybe_to_int(page_number)
        ]
      end

      defp get_params(_), do: []

      defp maybe_to_int(value) when is_bitstring(value), do: String.to_integer(value)
      defp maybe_to_int(value) when is_integer(value), do: value
      defp maybe_to_int(_), do: nil
    end
  end

  def paginate(queryable, opts, repo) do
    page_size = get_page_size(opts)
    page_number = Keyword.get(opts, :page_number, 1)

    entries = get_entries(queryable, page_number, page_size, repo)
    total_count = get_total_count(queryable, repo)
    total_pages = ceiling(total_count / page_size)

    Page.new(entries, page_number, page_size, total_pages, total_count)
  end

  defp get_entries(queryable, page_number, page_size, repo) do
    offset = page_size * (page_number - 1)

    queryable
    |> limit([_], ^page_size)
    |> offset([_], ^offset)
    |> repo.all()
  end

  defp get_total_count(queryable, repo) do
    queryable
    |> exclude(:order_by)
    |> exclude(:preload)
    |> exclude(:select)
    |> exclude(:group_by)
    |> select([e], count(e.id, :distinct))
    |> repo.one()
  end

  defp get_page_size(params) do
    Enum.min([params[:page_size], params[:maximum_page_size]])
  end

  defp ceiling(value) do
    value
    |> trunc()
    |> ceiling(value)
  end

  defp ceiling(truncated_value, value) when value - truncated_value > 0, do: truncated_value + 1
  defp ceiling(truncated_value, _), do: truncated_value
end
