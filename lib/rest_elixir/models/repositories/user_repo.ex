defmodule RestElixir.Models.Repositories.UserRepo do
  import Ecto.Query, warn: false
  alias RestElixir.Repo

  alias RestElixir.Models.Entities.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user!(id) do
    {:ok, Repo.get!(User, id) |> Repo.preload(:loans)}
  end

  def get_user_by_email!(email), do: Repo.get_by!(User, email: email)

end
