defmodule RestElixir.Repo.Migrations.CreateTbRolesAndTbUserRoles do
  use Ecto.Migration

  def change do
    create table(:tb_roles) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:tb_roles, [:name])

    create table(:tb_user_roles) do
      add :user_id, references(:tb_users, on_delete: :delete_all, type: :uuid)
      add :role_id, references(:tb_roles, on_delete: :delete_all)
    end

    create index(:tb_user_roles, [:user_id])
    create index(:tb_user_roles, [:role_id])
  end
end
