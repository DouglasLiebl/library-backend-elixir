defmodule RestElixir.Repo do
  use Ecto.Repo,
    otp_app: :rest_elixir,
    adapter: Ecto.Adapters.Postgres
end
