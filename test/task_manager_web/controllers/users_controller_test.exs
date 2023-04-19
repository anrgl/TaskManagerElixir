defmodule TaskManagerWeb.UsersControllerTest do
  use TaskManagerWeb.ConnCase
  use TaskManager.Factory

  alias TaskManager.Users.User

  @invalid_attrs %{email: nil, first_name: nil, last_name: nil, role: nil}
  @moduletag :user_controller

  setup %{conn: conn} do
    user = insert(:manager)
    {:ok, conn: log_in_user(conn, user), user: user}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      insert(:manager)
      conn = get(conn, ~p"/api/users")
      assert json_response(conn, 200)["data"] != []
    end

    test "filter by full name", %{conn: conn} do
      first_name = "test_first_name"
      last_name = "test_last_name"
      full_name = "#{first_name} #{last_name}"

      insert(:manager, %{first_name: first_name, last_name: last_name})
      insert(:developer)

      conn = get(conn, ~p"/api/users", full_name: full_name)

      assert [user] = json_response(conn, 200)["data"]
      assert user["first_name"] == first_name
      assert user["last_name"] == last_name
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      manager_params = params_for(:manager)

      conn = post(conn, ~p"/api/users", user: manager_params)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users/#{id}")
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      update_attrs = params_for(:manager)

      conn = put(conn, ~p"/api/users/#{user}", user: update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      first_name = update_attrs.first_name

      assert %{
               "id" => ^id,
               "first_name" => ^first_name
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "delete chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/users/#{user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/users/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = insert(:manager)
    %{user: user}
  end
end
