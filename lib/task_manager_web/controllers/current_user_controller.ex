defmodule TaskManagerWeb.CurrentUserController do
  use TaskManagerWeb, :controller
  use TaskManagerWeb.ApiDoc.CurrentUserDoc

  alias TaskManager.Users
  alias TaskManager.Users.User

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, :show, user: user)
  end

  def update_avatar(conn, user_params) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %User{} = user} <- Users.update_avatar(user, user_params) do
      render(conn, :show, user: user)
    end
  end
end
