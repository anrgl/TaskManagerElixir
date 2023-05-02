defmodule TaskManagerWeb.TagsControllerTest do
  use TaskManagerWeb.ConnCase
  use TaskManager.Factory

  alias TaskManager.Tags.Tag

  @invalid_attrs %{name: nil}
  @moduletag :tag_controller

  setup %{conn: conn} do
    user = insert(:manager)
    {:ok, conn: log_in_user(conn, user), user: user}
  end

  describe "index" do
    test "lists all tags", %{conn: conn} do
      insert(:tag)
      conn = get(conn, ~p"/api/tags")
      assert json_response(conn, 200)["data"] != []
    end

    test "filter by name", %{conn: conn} do
      name = "test_tag_name"

      insert(:tag, %{name: name})
      insert(:tag)

      conn = get(conn, ~p"/api/tags", name: name)

      assert [tag] = json_response(conn, 200)["data"]
      assert tag["name"] == name
    end
  end

  describe "create tag" do
    test "renders tag when data is valid", %{conn: conn} do
      tag_params = params_for(:tag)

      conn = post(conn, ~p"/api/tags", tag: tag_params)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/tags/#{id}")
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/tags", tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tag" do
    setup [:create_tag]

    test "renders tag when data is valid", %{conn: conn, tag: %Tag{id: id} = tag} do
      update_attrs = params_for(:tag)

      conn = put(conn, ~p"/api/tags/#{tag}", tag: update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/tags/#{id}")

      name = update_attrs.name

      assert %{
               "id" => ^id,
               "name" => ^name
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tag: tag} do
      conn = put(conn, ~p"/api/tags/#{tag}", tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tag" do
    setup [:create_tag]

    test "delete chosen tag", %{conn: conn, tag: tag} do
      conn = delete(conn, ~p"/api/tags/#{tag}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/tags/#{tag}")
      end
    end
  end

  defp create_tag(_) do
    tag = insert(:tag)
    %{tag: tag}
  end
end
