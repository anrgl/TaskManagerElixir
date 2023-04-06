defmodule TaskManager.Tags.Filter do
  use TaskManager.Core.Filter

  def filter_on_attribute({"name", name}, query) do
    where(
      query,
      [e],
      ilike(e.name, ^"%#{name}%")
    )
  end

  def filter_on_attribute(_, query), do: query
end
