defmodule TaskManager.Users.Filter do
  use TaskManager.Core.Filter

  def filter_on_attribute({"full_name", name}, query) do
    where(
      query,
      [e],
      ilike(fragment("CONCAT(?, ' ', ?)", e.first_name, e.last_name), ^"%#{name}")
    )
  end

  def filter_on_attribute(_, query), do: query
end
