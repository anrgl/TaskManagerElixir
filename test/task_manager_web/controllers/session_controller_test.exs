defmodule TaskManagerWeb.SessionControllerTest do
  use TaskManagerWeb.ConnCase
  use TaskManager.UserFactory

  alias TaskManager.Users.User

  @invalid_credentials %{email: "invalid@email.com", password: "invalidpassword"}

  @moduletag :session_controller

  describe "create" do
    test "renders data when credentials is valid", %{conn: conn} do
      email = "valid@email.com"
      password = "superpassword"
      hashed_password = Argon2.hash_pwd_salt(password)

      insert(:manager, email: email, password: password, hashed_password: hashed_password)

      conn = post(conn, ~p"/api/sessions", email: email, password: password)
      assert data = json_response(conn, 201)["data"]
      assert data["email"] == email
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
