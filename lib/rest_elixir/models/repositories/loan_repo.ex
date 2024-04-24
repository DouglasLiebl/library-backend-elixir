defmodule RestElixir.Models.Repositories.LoanRepo do
  alias RestElixir.Repo

  alias RestElixir.Models.Entities.Loan

  def create_loan(attrs \\ %{}) do
    %Loan{}
    |> Loan.changeset(attrs)
    |> Repo.insert()
  end

end
