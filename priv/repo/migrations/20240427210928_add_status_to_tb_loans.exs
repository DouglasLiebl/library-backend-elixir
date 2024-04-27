defmodule RestElixir.Repo.Migrations.AddStatusToTbLoans do
  use Ecto.Migration

  def up do
    alter table(:tb_loans) do
      add :status, :string
    end

    execute "ALTER TABLE tb_loans ADD CONSTRAINT check_status CHECK (status IN ('PENDING', 'DONE'))"
  end
end
