defmodule TaskManager.Core.Filter do
  defmacro __using__(_opts) do
    quote do
      @behaviour TaskManager.Core.Filter

      import Ecto.Query

      def filter_query(query, nil), do: query

      def filter_query(query, params) do
        params
        |> Enum.reject(&(elem(&1, 1) == ""))
        |> Enum.reduce(query, &__MODULE__.filter_on_attribute/2)
      end
    end
  end

  @callback filter_on_attribute(any(), any()) :: any()
end
