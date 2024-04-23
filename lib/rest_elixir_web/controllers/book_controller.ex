defmodule RestElixirWeb.BookController do
  use RestElixirWeb, :controller

  alias RestElixir.Models.Entities.Book
  alias RestElixir.Models.Repositories.BookRepo

  action_fallback RestElixirWeb.FallbackController

  def index(conn, _params) do
    render(conn, :index, books: BookRepo.list_books())
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- BookRepo.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/books/#{book}")
      |> render(:show, book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      conn
      |> render(:show, book: BookRepo.get_book!(id))
    rescue
      _e in Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    try do
      {:ok, book} = BookRepo.update_book(BookRepo.get_book!(id), book_params)

      conn
      |> put_status(:ok)
      |> render(:show, book: book)
    rescue
      _e in Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      BookRepo.get_book!(id)
      |> BookRepo.delete_book()

      conn
      |> send_resp(:no_content, "")
    rescue
      _e in Ecto.NoResultsError -> {:error, :not_found}
    end
  end

end
