defmodule RestElixirWeb.Auth.RoleFilter do
  use RestElixirWeb, :controller

  alias RestElixirWeb.Auth.Guardian

  def call(conn, opts) do
    get_resource_from_token(conn, Keyword.get(opts, :role))
  end

  def get_resource_from_token(conn, role) do
    [token | _] = get_req_header(conn, "authorization")

    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        case check_role(claims, role) do
          :ok -> conn
          :error ->
            conn
            |> put_status(:unauthorized)
            |> json(%{error: "Unauthorized: No Permission to access this resource"})
        end

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Unauthorized: Invalid Token"})
    end
  end

  def check_role(%{"roles" => roles}, required_role) do
    if Enum.member?(roles, required_role) do
      :ok
    else
      :error
    end
  end

end
