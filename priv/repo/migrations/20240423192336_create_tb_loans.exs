defmodule RestElixir.Repo.Migrations.CreateTbLoans do
  use Ecto.Migration

  def change do
    create table(:tb_loans, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :book_id, references(:tb_books, type: :binary_id)
      add :user_id, references(:tb_users, type: :binary_id)
      add :loan_date, :date
      add :return_date, :date

      timestamps(type: :utc_datetime)
    end

    create index(:tb_loans, [:book_id])
    create index(:tb_loans, [:user_id])
  end
end
