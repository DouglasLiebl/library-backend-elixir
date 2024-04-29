defmodule RestElixir.Models.Entities.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tb_roles" do
    field :name, :string
    many_to_many :users, RestElixir.Models.Entities.User, join_through: "tb_user_roles"

    timestamps(type: :utc_datetime)
  end

  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

end
