defmodule TaskManager.Users.UserRole do
  @moduledoc """
  Ecto type for User Role
  """

  use TaskManager.Core.UpcaseInclusionString

  @impl true
  def value_map do
    %{
      developer: "DEVELOPER",
      manager: "MANAGER",
      admin: "ADMIN"
    }
  end
end
