defmodule RestElixirWeb.Auth.TokenFilter do
  use RestElixirWeb, :controller

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      [] ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Unauthorized: No Authorization header"})
      _ -> conn
    end
  end

end
