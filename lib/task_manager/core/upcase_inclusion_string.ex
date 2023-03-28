defmodule TaskManager.Core.UpcaseInclusionString do
  @moduledoc """
  Abstract UpperCased string with restricted values ecto type
  """

  @doc """
  Map of restricted values
  """
  @callback value_map() :: map()
  defmacro __using__(_opts) do
    quote do
      @behaviour TaskManager.Core.UpcaseInclusionString
      use Ecto.Type

      @impl true
      def type, do: :string

      @impl true
      def cast(data)

      def cast(data) when is_binary(data) do
        cast_data = String.upcase(data)

        if cast_data in values() do
          {:ok, cast_data}
        else
          :error
        end
      end

      def cast(_), do: :error

      @impl true
      def load(data), do: {:ok, String.upcase(data)}

      @impl true
      def dump(data), do: {:ok, String.upcase(data)}

      def values, do: Map.values(__MODULE__.value_map())

      def values(keys) do
        __MODULE__.value_map()
        |> Map.take(keys)
        |> Map.values()
      end

      def value!(key) when is_atom(key), do: Map.fetch!(__MODULE__.value_map(), key)

      def value(key) when is_atom(key), do: Map.get(__MODULE__.value_map(), key)
    end
  end
end
