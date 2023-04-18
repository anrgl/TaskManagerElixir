defmodule TaskManagerWeb.ErrorHandler do
  import Plug.Conn
  import Phoenix.Controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, _, _) do
    conn
    |> put_status(:unauthorize)
    |> put_view(TaskManagerWeb.ErrorJSON)
    |> render("401.json")
  end
end
