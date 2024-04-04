defmodule RestElixir.Repo.Migrations.CreateTbUsers do
  use Ecto.Migration

  def change do
    create table(:tb_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :hash_password, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:tb_users, [:email])
  end
end
