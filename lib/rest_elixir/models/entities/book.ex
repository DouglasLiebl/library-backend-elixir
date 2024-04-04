defmodule RestElixir.Models.Entities.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tb_books" do
    field :title, :string
    field :author, :string
    field :isbn, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :isbn])
    |> validate_required([:title, :author, :isbn])
    |> unique_constraint([:isbn])
  end

end
