defmodule TaskManagerWeb.SessionControllerTest do
  use TaskManagerWeb.ConnCase
  use TaskManager.UserFactory

  alias TaskManager.Users.User

  @valid_credentials %{email: "valid@email.com", password: "superpassword"}
  @invalid_credentials %{email: "invalid@email.com", password: "invalidpassword"}

  @moduletag :session_controller

  describe "create" do
    test "renders data when credentials is valid", %{conn: conn} do
      manager_params = params_for(:manager, @valid_credentials)
      post(conn, ~p"/api/users", user: manager_params)

      conn = post(conn, ~p"/api/sessions", @valid_credentials)
      assert data = json_response(conn, 201)["data"]
      assert data["email"] == @valid_credentials.email
    end

    test "renders error when credentials is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/sessions", @invalid_credentials)

      assert error = json_response(conn, 422)["error"]
      assert error == "invalid_credentials"
    end
  end

  describe "delete" do
    test "delete current session", %{conn: conn} do
      conn = delete(conn, ~p"/api/sessions")
      assert conn.status == 204
    end
  end
end
