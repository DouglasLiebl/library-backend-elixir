defmodule RestElixir.Models.Repositories.BookRepo do
  import Ecto.Query, warn: false
  alias RestElixir.Repo

  alias RestElixir.Models.Entities.Book

  def list_books do
    Repo.all(Book)
  end

  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  def get_book!(id), do: Repo.get!(Book, id)
end
