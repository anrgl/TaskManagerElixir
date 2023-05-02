defmodule TaskManager.UsersTest do
  use TaskManager.DataCase
  use TaskManager.Factory

  alias TaskManager.Users
  alias TaskManager.Users.User

  @moduletag :users_test

  describe "users" do
    @invalid_attrs %{email: nil, first_name: nil, password: nil, last_name: nil, role: nil}

    test "list_users/0 returns all users" do
      insert(:manager)
      assert Users.list_users() != []
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:manager)
      assert Users.get_user!(user.id).id == user.id
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = params_for(:admin)

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.email == valid_attrs.email
      assert user.first_name == valid_attrs.first_name
      assert user.last_name == valid_attrs.last_name
      assert user.role == UserRole.value!(:admin)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:developer)

      update_attrs = params_for(:developer)

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.email == update_attrs.email
      assert user.first_name == update_attrs.first_name
      assert user.last_name == update_attrs.last_name
      assert user.role == UserRole.value!(:developer)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:developer)
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user.id == Users.get_user!(user.id).id
    end

    test "delete_user/1 deletes the user" do
      user = insert(:developer)
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:developer)
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
