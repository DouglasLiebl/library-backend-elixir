defmodule RestElixirWeb.BookJSON do
  alias RestElixir.Models.Entities.Book

  def index(%{books: books}) do
    %{data: for(book <- books, do: data(book)) }
  end

  def show(%{book: book}) do
    %{data: data(book)}
  end

  defp data(%Book{} = book) do
    %{
      id: book.id,
      title: book.title,
      author: book.author,
      isbn: book.isbn,
      inserted_at: book.inserted_at,
      updated_at: book.updated_at
    }
  end

  def show_error({:error, changeset}) do
    errors = changeset.errors
    %{message: errors}
  end
end
