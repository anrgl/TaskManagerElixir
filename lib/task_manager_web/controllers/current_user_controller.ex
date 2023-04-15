defmodule TaskManagerWeb.CurrentUserController do
  use TaskManagerWeb, :controller

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, :show, user: user)
  end
end
