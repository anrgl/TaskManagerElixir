defmodule TaskManagerWeb.CurrentUserControllerTest do
  use TaskManagerWeb.ConnCase
  use TaskManager.Factory

  @moduletag :current_user_controller

  setup %{conn: conn} do
    user = insert(:manager)
    {:ok, conn: log_in_user(conn, user), user: user}
  end

  test "get current user", %{conn: conn, user: user} do
    conn = get(conn, ~p"/api/user")

    expected_user = %{
      "id" => user.id,
      "first_name" => user.first_name,
      "last_name" => user.last_name,
      "email" => user.email,
      "role" => user.role,
      "avatar" => nil
    }

    assert %{"data" => ^expected_user} = json_response(conn, 200)
  end

  describe "update user avatar" do
    test "renders user when data is valid", %{conn: conn} do
      avatar_params = get_avatar_params()

      conn = put(conn, ~p"/api/user/avatar", avatar: avatar_params)
      assert json_response(conn, 200)

      conn = get(conn, ~p"/api/user")

      avatar = "/uploads/#{avatar_params.filename}"

      assert %{"avatar" => ^avatar} = json_response(conn, 200)["data"]
    end
  end

  defp get_avatar_params do
    %Plug.Upload{
      path: "test/support/files/avatar.jpeg",
      filename: "avatar.jpeg"
    }
  end
end
