defmodule RestElixirWeb.FallbackJSON do

  @doc """
    1. Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} -> ... end): Esta linha está chamando a função `traverse_errors/2` do módulo `Ecto.Changeset`. Esta função recebe um `changeset` e uma função anônima como argumentos. Ela percorre todos os erros no `changeset` e aplica a função anônima a cada erro.

    2. fn {msg, opts} -> ... end: Esta é a função anônima que é aplicada a cada erro no `changeset`. Cada erro é uma tupla que contém uma mensagem de erro e opções associadas a esse erro. A função anônima é definida para aceitar essa tupla como argumento.

    3. Enum.reduce(opts, msg, fn {key, value}, acc -> ... end): Esta linha está chamando a função `reduce/3` do módulo `Enum`. Esta função recebe uma enumeração (neste caso, as opções associadas ao erro), um acumulador inicial (neste caso, a mensagem de erro) e uma função anônima. Ela aplica a função anônima a cada elemento na enumeração e ao acumulador, e retorna o valor final do acumulador.

    4. fn {key, value}, acc -> ... end: Esta é a função anônima que é aplicada a cada opção e ao acumulador. Cada opção é uma tupla que contém uma chave e um valor. A função anônima é definida para aceitar essa tupla e o acumulador como argumentos.

    5. String.replace(acc, "%{key}", to_string(value)): Esta linha está chamando a função `replace/3` do módulo `String`. Esta função recebe uma string (neste caso, o acumulador), um padrão (neste caso, uma string que contém a chave da opção) e uma substituição (neste caso, o valor da opção convertido em uma string). Ela retorna uma nova string onde todas as ocorrências do padrão foram substituídas pela substituição.

    No final, a variável `errors` contém um mapa onde cada chave é um campo que tem um erro e cada valor é uma string que contém a mensagem de erro formatada para esse campo.
  """
  def unprocessable_entity(%{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", fn _ -> to_string(value) end)
    end)
  end

  def not_found(_) do
    %{errors: "NotFound"}
  end

end
