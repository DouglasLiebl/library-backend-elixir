defmodule RestElixirWeb.Auth.Guardian do
  use Guardian, otp_app: :rest_elixir

  alias RestElixir.Models.Repositories.UserRepo

  @spec subject_for_token(any(), any()) :: {:error, :no_email_provided} | {:ok, binary()}
  def subject_for_token(%{email: email}, _claims) do
    {:ok, to_string(email)}
  end

  def subject_for_token(_, _) do
    {:error, :no_email_provided}
  end

  def resource_from_claims(%{"sub" => email}) do
    case UserRepo.get_user_by_email!(email) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_email_provided}
  end

  def authenticate(email, password) do
    case UserRepo.get_user_by_email!(email) do
      nil -> {:error, :unauthored}
      user ->
        case validate_password(password, user.hash_password) do
          true -> create_token(user)
          false -> {:error, :unauthorized}
        end

    end
  end

  defp validate_password(password, hash_password) do
    Argon2.verify_pass(password, hash_password)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user, %{role: "USER"})
    {:ok, user, token}
  end
end
