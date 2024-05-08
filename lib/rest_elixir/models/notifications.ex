defmodule RestElixir.Models.Notifications do
  import Swoosh.Email

  alias RestElixir.Mailer

  def sample() do
    mail =
      new()
      |> to("")
      |> from("")
      |> subject("Test")
      |> text_body("Sample Text")

    with {:ok, response} <- Mailer.deliver(mail) do
      IO.inspect(response)
    else
      {:error, reason} -> IO.inspect(reason)
    end

    IO.inspect(mail)
  end


end
