# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RestElixir.Repo.insert!(%RestElixir.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias RestElixir.Repo
alias RestElixir.Models.Entities.Role

roles = ["ROLE_USER", "ROLE_MANAGER", "ROLE_ADMIN"]

for role <- roles do
  %Role{name: role}
  |> Repo.insert!()
end
