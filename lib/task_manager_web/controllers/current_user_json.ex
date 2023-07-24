defmodule TaskManagerWeb.CurrentUserJSON do
  alias TaskManager.Users.User
  alias TaskManager.AvatarFile

  def show(%{user: %User{} = user}) do
    %{
      data: %{
        id: user.id,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        role: user.role,
        avatar: AvatarFile.url({user.avatar, user}, signed: true)
      }
    }
  end
end
