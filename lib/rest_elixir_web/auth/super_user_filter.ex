defmodule RestElixirWeb.Auth.SuperUserFilter do
  use RestElixirWeb, :controller

  alias RestElixirWeb.Auth.Guardian

  def init(_default), do: "SuperUser Filter Init"

  def call(conn, _opts) do
    get_resource_from_token(conn)
  end

  def get_resource_from_token(conn) do
    [token | _] = get_req_header(conn, "authorization")

    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        case check_role(claims) do
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

  def check_role(%{"role" => role}) do
    case role do
      "ADMIN" -> :ok
      _ -> :error
    end
  end

end
