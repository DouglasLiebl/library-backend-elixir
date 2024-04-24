defmodule RestElixirWeb.LoanController do
  use RestElixirWeb, :controller

  alias RestElixir.Models.Entities.{Loan, Book, User}
  alias RestElixir.Models.Repositories.{LoanRepo, BookRepo, UserRepo}

  action_fallback RestElixirWeb.FallbackController

  def create(conn, %{"loan" => loan_params}) do
    try do
      with {:ok, %Book{} = book} <- BookRepo.is_book_available?(Map.get(loan_params, "book_id")), {:ok, %User{} = user} <- UserRepo.get_user!(Map.get(loan_params, "user_id")), {:ok, %Loan{} = loan} <- LoanRepo.create_loan(loan_params) do

        conn
        |> put_status(:created)
        |> render(:show, %{loan: loan, book: book, user: user})
      end
    rescue
      _e in RuntimeError -> {:error, :unavailable}
      _e in Ecto.NoResultsError -> {:error, :not_found}
    end
  end
end
