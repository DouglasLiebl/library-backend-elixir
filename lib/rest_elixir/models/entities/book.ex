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
    |> put_status(attrs)
    |> unique_constraint([:isbn])
  end

  defp put_status(changeset, attrs) do
    if Map.has_key?(attrs, :status) do
      put_change(changeset, :status, "UNAVAILABLE")
    else
      put_change(changeset, :status, "AVAILABLE")
    end
  end

end
