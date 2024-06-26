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

  def get_book!(id), do: Repo.get!(Book, id) |> Repo.preload(:loans)

  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end

  def is_book_available?(id) do
    case get_book!(id) do
      %Book{status: "AVAILABLE"} = book ->
        IO.inspect(book)
        {:ok, book}
      _ -> raise "UNAVAILABLE"
    end
  end
end
