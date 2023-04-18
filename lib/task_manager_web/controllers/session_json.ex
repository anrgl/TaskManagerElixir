defmodule TaskManagerWeb.SessionJSON do
  alias TaskManager.Users.User

  def show(%{user: %User{} = user}) do
    %{
      data: %{
        id: user.id,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        role: user.role
      }
    }
  end

  def error(%{reason: reason}) do
    %{
      error: Atom.to_string(reason)
    }
  end
end
