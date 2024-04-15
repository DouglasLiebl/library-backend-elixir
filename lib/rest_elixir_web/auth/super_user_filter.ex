defmodule RestElixirWeb.Auth.SuperUserFilter do

  def init(_default), do: "SuperUser Filter Init"

  def call(conn, _opts) do
    IO.puts("super_user filter reached")
    conn
  end
end
