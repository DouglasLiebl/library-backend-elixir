defmodule RestElixirWeb.BookController do
  use RestElixirWeb, :controller

  alias RestElixirWeb.FallbackJSON
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
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(FallbackJSON.show_error(changeset))
    end
  end

  def show(conn, %{"id" => id}) do
    conn
    |> render(:show, book: BookRepo.get_book(id))
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    with {:ok, %Book{} = book} <- BookRepo.update_book(BookRepo.get_book(id), book_params) do
      render(conn, :show, book: book)
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(FallbackJSON.show_error(changeset))
    end
  end

  def delete(conn, %{"id" => id}) do
    case BookRepo.get_book(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(FallbackJSON.not_found(id))
      %Book{} = book ->
        with {:ok, %Book{}} <- BookRepo.delete_book(book) do
          conn
          |> send_resp(:no_content, "")
        end
    end
  end

end
