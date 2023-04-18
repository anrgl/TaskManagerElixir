defmodule TaskManager.Users.User do
  alias TaskManager.Repo
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskManager.Users.UserRole

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true
    field :last_name, :string
    field :role, UserRole

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :role, :first_name, :last_name, :password])
    |> validate_required([:email, :role, :first_name, :last_name, :password])
    |> validate_email(:email)
    |> validate_and_hash_password()
  end

  defp validate_email(changeset, field) when is_atom(field) do
    changeset
    |> validate_required([field])
    |> validate_format(field, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(field, max: 160)
    |> unsafe_validate_unique(field, Repo)
    |> unique_constraint(field)
  end

  defp validate_and_hash_password(changeset) do
    password = get_change(changeset, :password)
    validate_and_hash_existing_password(changeset, password)
  end

  defp validate_and_hash_existing_password(changeset, nil), do: changeset

  defp validate_and_hash_existing_password(changeset, password) do
    changeset
    |> validate_length(:password, min: 12, max: 72)
    |> put_change(:hashed_password, Argon2.hash_pwd_salt(password))
    |> delete_change(:password)
  end

  def valid_password?(%__MODULE__{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Argon2.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Argon2.no_user_verify()
    false
  end
end
