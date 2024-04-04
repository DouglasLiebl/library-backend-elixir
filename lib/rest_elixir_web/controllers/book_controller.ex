defmodule RestElixirWeb.BookController do
  use RestElixirWeb, :controller

  alias RestElixir.Models.Entities.Book
  alias RestElixir.Models.Repositories.BookRepo

  def index(conn, _params) do
    render(conn, :index, books: BookRepo.list_books())
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- BookRepo.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/books/#{book}")
      |> render(:show, book: book)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:show_error, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    conn
    |> render(:show, book: BookRepo.get_book!(id))
  end

end
