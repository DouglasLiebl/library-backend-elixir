defmodule RestElixirWeb.UserJSON do
  alias RestElixir.Models.Entities.User

  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      hash_password: user.hash_password,
      roles: (for role <- user.roles, do: %{id: role.id, name: role.name}),
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  def logged(%{token: token}) do
    %{
      access_token: token
    }
  end
end
