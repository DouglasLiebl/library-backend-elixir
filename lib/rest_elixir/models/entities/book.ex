defmodule RestElixir.Models.Entities.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tb_books" do
    field :title, :string
    field :author, :string
    field :isbn, :string
    field :image_url, :string
    field :status, :string
    has_many :loans, RestElixir.Models.Entities.Loan

    timestamps(type: :utc_datetime)
  end

  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :isbn, :image_url])
    |> validate_required([:title, :author, :isbn, :image_url])
    |> put_change(:status, "AVAILABLE")
    |> unique_constraint([:isbn])
  end

end
