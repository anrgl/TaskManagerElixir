defmodule TaskManagerWeb.FallbackController do
  use TaskManagerWeb, :controller

  alias TaskManagerWeb.ChangesetJSON

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ChangesetJSON)
    |> render(:error, changeset: changeset)
  end
end
