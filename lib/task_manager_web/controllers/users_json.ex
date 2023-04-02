defmodule TaskManagerWeb.UsersJSON do
  alias TaskManager.Users.User

  import TaskManagerWeb.PaginationJSON

  def index(%{users: users, pagination: pagination}) do
    %{
      data: for(user <- users, do: data(user)),
      metadata: render(%{pagination: pagination})
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
      role: user.role
    }
  end
end
