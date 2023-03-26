defmodule TaskManager.TagsTest do
  use TaskManager.DataCase
  use TaskManager.TagFactory

  alias TaskManager.Tags
  alias TaskManager.Tags.Tag

  @moduletag :tags_test

  describe "tags" do
    @invalid_attrs %{name: nil}

    test "list_tags/0 returns all tags" do
      insert(:tag)
      assert Tags.list_tags() != []
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = insert(:tag)
      assert Tags.get_tag!(tag.id).id == tag.id
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = params_for(:tag)

      assert {:ok, %Tag{} = tag} = Tags.create_tag(valid_attrs)
      assert tag.name == valid_attrs.name
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tags.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = insert(:tag)
      update_attrs = params_for(:tag)

      assert {:ok, %Tag{} = tag} = Tags.update_tag(tag, update_attrs)
      assert tag.name == update_attrs.name
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = insert(:tag)
      assert {:error, %Ecto.Changeset{}} = Tags.update_tag(tag, @invalid_attrs)
      assert tag == Tags.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = insert(:tag)
      assert {:ok, %Tag{}} = Tags.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Tags.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = insert(:tag)
      assert %Ecto.Changeset{} = Tags.change_tag(tag)
    end
  end
end
