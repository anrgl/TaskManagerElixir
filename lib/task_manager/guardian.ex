defmodule TaskManager.Guardian do
  use Guardian, otp_app: :task_manager

  alias TaskManager.Users
  alias TaskManager.Users.User

  def subject_for_token(%User{id: id}, _claims), do: {:ok, to_string(id)}
  def subject_for_toke(_, _), do: {:error, :undefinde_object}

  def resource_from_claims(%{"sub" => id}) do
    resource = Users.get_user!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims), do: {:error, :user_not_found}
end
