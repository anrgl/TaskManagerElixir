defmodule TaskManagerWeb.TagsJSON do
  alias TaskManager.Tags.Tag

  import TaskManagerWeb.PaginationJSON

  def index(%{tags: tags, pagination: pagination}) do
    %{
      data: for(tag <- tags, do: data(tag)),
      metadata: render(%{pagination: pagination})
    }
  end

  def show(%{tag: tag}) do
    %{data: data(tag)}
  end

  defp data(%Tag{} = tag) do
    %{
      id: tag.id,
      name: tag.name
    }
  end
end
