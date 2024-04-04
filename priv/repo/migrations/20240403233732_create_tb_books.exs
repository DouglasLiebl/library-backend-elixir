defmodule RestElixir.Repo.Migrations.CreateTbBooks do
  use Ecto.Migration

  def change do
    create table(:tb_books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :author, :string
      add :isbn, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:tb_books, [:isbn])
  end
end
