defmodule RestElixirWeb.Auth.SuperUserFilter do
  use RestElixirWeb, :controller
  alias RestElixirWeb.Auth.Guardian

  def init(_default), do: "SuperUser Filter Init"

  def call(conn, _opts) do
    get_resource_from_token(conn)
  end

  def get_resource_from_token(conn) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      [token | _] ->
        case Guardian.decode_and_verify(token) do
          {:ok, claims} ->
            case check_role(claims) do
              :ok -> conn
              :error ->
                conn
                |> put_status(:unauthorized)
                |> json(%{error: "Unauthorized"})
            end

          {:error, reason} ->
            IO.inspect(reason, label: "error")
        end
      [] ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Unauthorized: No Authorization header"})
    end
  end

  def check_role(%{"role" => role}) do
    case role do
      "ADMIN" -> :ok
      _ -> :error
    end
  end

end
