defmodule RestElixir.Models.Entities.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tb_users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :hash_password, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :hash_password])
    |> validate_required([:first_name, :last_name, :email, :hash_password])
    |> unique_constraint([:email])
    |> put_hash_password()
  end

  defp put_hash_password(%Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset) do
    IO.inspect(hash_password, label: "password")
    change(changeset, hash_password: Argon2.hash_pwd_salt(hash_password))
  end

  defp put_hash_password(changeset), do: changeset

end
