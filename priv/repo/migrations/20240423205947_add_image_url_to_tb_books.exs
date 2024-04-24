defmodule RestElixir.Repo.Migrations.AddImageUrlToTbBooks do
  use Ecto.Migration

  def up do
    alter table(:tb_books) do
      add :image_url, :string
      add :status, :string
    end

    execute "ALTER TABLE tb_books ADD CONSTRAINT check_status CHECK (status IN ('AVAILABLE', 'UNAVAILABLE'))"
  end
end
