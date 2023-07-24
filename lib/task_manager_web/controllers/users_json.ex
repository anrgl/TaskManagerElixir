defmodule TaskManagerWeb.UsersJSON do
  alias TaskManager.Users.User
  alias TaskManager.AvatarFile

  import TaskManagerWeb.PaginationJSON

  def index(%{users: users, pagination: _} = data) do
    %{
      data: for(user <- users, do: data(user)),
      metadata: render(data)
    }
  end

  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      role: user.role,
      avatar: AvatarFile.url({user.avatar, user}, signed: true)
    }
  end
end
