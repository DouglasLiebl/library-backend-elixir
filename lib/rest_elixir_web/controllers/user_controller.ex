defmodule RestElixirWeb.UserController do
  use RestElixirWeb, :controller

  alias RestElixirWeb.Auth.Guardian
  alias RestElixir.Models.Entities.User
  alias RestElixir.Models.Repositories.UserRepo

  alias RestElixir.Models.Notifications

  action_fallback RestElixirWeb.FallbackController

  def show(conn, %{"email" => email}) do
    try do
      conn
      |> render(:show, user: UserRepo.get_user_by_email!(email))
    rescue
      _e in Ecto.NoResultsError -> {:error, :not_found}
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- UserRepo.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user.email}")
      |> render(:show, user: user)
    end
  end

  def test(conn, _params) do
    Notifications.sample()

    conn |> put_status(:ok) |> render(:logged, %{token: "xdxdss"})
  end

  def login(conn, %{"email" => email, "hash_password" => password}) do
    case Guardian.authenticate(email, password) do
      {:ok, _user, token} ->
        conn
        |> put_status(:ok)
        |> render(:logged, %{token: token})
    end
  end

end
