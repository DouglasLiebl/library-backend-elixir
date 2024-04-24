defmodule RestElixirWeb.LoanJSON do
  alias RestElixir.Models.Entities.{Book, Loan, User}

  def show(%{loan: loan, book: book, user: user}) do
    %{data: data(loan, book, user)}
  end

  defp data(%Loan{} = loan, %Book{} = book, %User{} = user) do
    %{
      id: loan.id,
      loan_date: loan.loan_date,
      return_date: loan.return_date,
      book: %{
        id: book.id,
        title: book.title,
        author: book.author,
        isbn: book.isbn
      },
      user: %{
        id: user.id,
        email: user.email
      }
    }
  end

end
