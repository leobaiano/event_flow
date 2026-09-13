defmodule EventFlowWeb.UserJSON do
  @moduledoc """
  Módulo responsável por formatar a resposta JSON para o recurso User.
  """
  alias EventFlow.Accounts.User

  @doc """
  Renderiza um único usuário.
  """
  def show(%{user: %User{} = user}) do
    %{
      data: data(user)
    }
  end

  @doc """
  Renderiza a lista completa de usuários.
  """
  def index(%{users: users}) do
    %{
      data: for(user <- users, do: data(user))
    }
  end

  # Função privada auxiliar para formatar cada usuário da lista
  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      inserted_at: user.inserted_at
    }
  end

  @doc """
  Renderiza os erros de validação do Changeset em formato JSON.
  """
  def error(%{changeset: changeset}) do
    errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)

    %{errors: errors}
  end
end
