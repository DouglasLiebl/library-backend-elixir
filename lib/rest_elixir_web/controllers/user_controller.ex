defmodule RestElixirWeb.UserController do
  use RestElixirWeb, :controller

  alias RestElixirWeb.Auth.Guardian
  alias RestElixirWeb.FallbackJSON
  alias RestElixir.Models.Entities.User
  alias RestElixir.Models.Repositories.UserRepo

  def show(conn, %{"email" => email}) do
    [auth_header | _] = Plug.Conn.get_req_header(conn, "authorization")
    get_resource_from_token(auth_header)

    conn
    |> render(:show, user: UserRepo.get_user_by_email(email))
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- UserRepo.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user.email}")
      |> render(:show, user: user)
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(FallbackJSON.show_error(changeset))
    end
  end

  def login(conn, %{"email" => email, "hash_password" => password}) do
    case Guardian.authenticate(email, password) do
      {:ok, user, token} ->
        conn
        |> put_status(:ok)
        |> render(:logged, %{user: user, token: token})
    end
  end

  def get_resource_from_token(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        RestElixirWeb.Auth.Guardian.resource_from_claims(claims)

      {:error, reason} ->
        IO.inspect(reason, label: "error")
    end
  end
end
