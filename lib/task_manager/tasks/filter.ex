defmodule TaskManager.Tasks.Filter do
  use TaskManager.Core.Filter

  def filter_on_attribute({"title", title}, query) do
    where(
      query,
      [e],
      ilike(e.title, ^"%#{title}%")
    )
  end

  def filter_on_attribute(_, query), do: query
end
