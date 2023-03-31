defmodule TaskManagerWeb.TagsJSON do
  alias TaskManager.Tags.Tag

  def index(%{tags: tags}) do
    %{data: for(tag <- tags, do: data(tag))}
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
