defmodule TaskManager.Users.User do
  alias TaskManager.Repo
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :hashed_password, :string
    field :last_name, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :role, :first_name, :last_name, :hashed_password])
    |> validate_required([:email, :role, :first_name, :last_name, :hashed_password])
    |> validate_email(:email)
  end

  defp validate_email(changeset, field) when is_atom(field) do
    changeset
    |> validate_required([field])
    |> validate_format(field, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(field, max: 160)
    |> unsafe_validate_unique(field, Repo)
    |> unique_constraint(field)
  end
end
