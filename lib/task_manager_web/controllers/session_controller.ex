defmodule TaskManagerWeb.SessionController do
  use TaskManagerWeb, :controller

  alias TaskManager.Users
  alias TaskManager.Users.User
  alias TaskManager.Guardian

  def create(conn, %{"email" => email, "password" => password}) do
    case Users.user_auth(email, password) do
      {:ok, %User{} = user} ->
        conn
        |> renew_session()
        |> Guardian.Plug.sign_in(user)
        |> put_status(:created)
        |> render(:show, user: user)

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, reason: reason)
    end
  end

  def delete(conn, _params) do
    conn
    |> renew_session()
    |> Guardian.Plug.sign_out()
    |> send_resp(204, "")
  end

  defp renew_session(conn) do
    conn
    |> configure_session(renew: true)
    |> clear_session()
  end
end
