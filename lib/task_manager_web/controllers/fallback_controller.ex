defmodule TaskManagerWeb.FallbackController do
  use TaskManagerWeb, :controller

  alias TaskManagerWeb.ChangesetView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
