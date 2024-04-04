defmodule RestElixirWeb.UserController do
  use RestElixirWeb, :controller

  alias RestElixirWeb.FallbackJSON
  alias RestElixir.Models.Entities.User
  alias RestElixir.Models.Repositories.UserRepo

  def show(conn, %{"email" => email}) do
    conn
    |> render(:show, user: UserRepo.get_user_by_email(email))
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- UserRepo.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(FallbackJSON.show_error(changeset))
    end
  end
end
