defmodule RestElixirWeb.FallbackController do
alias RestElixirWeb.FallbackJSON

  use RestElixirWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: FallbackJSON)
    |> render(:unprocessable_entity, changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: FallbackJSON)
    |> render(:not_found)
  end
end
