defmodule RestElixir.Models.Entities.Loan do
  use Ecto.Schema
  import Ecto.Changeset

  alias RestElixir.Models.Entities.{Book, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tb_loans" do
    belongs_to :book, Book, type: :binary_id
    belongs_to :user, User, type: :binary_id
    field :loan_date, :date
    field :return_date, :date

    timestamps(type: :utc_datetime)
  end

  def changeset(loan, attrs) do
    IO.inspect(loan)
    IO.inspect(attrs)

    loan
    |> cast(attrs, [:book_id, :user_id])
    |> validate_required([:book_id, :user_id])
    |> put_change(:loan_date, Date.utc_today())
    |> put_change(:return_date, Date.add(Date.utc_today(), 5))
    |> foreign_key_constraint(:book_id)
    |> foreign_key_constraint(:user_id)
  end


end
