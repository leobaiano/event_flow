defmodule EventFlow.Accounts do
  @moduledoc """
  O contexto Accounts é a fronteira (boundary) do domínio de gerenciamento de usuários.
  """

  import Ecto.Query, warn: false
  alias EventFlow.Repo
  alias EventFlow.Accounts.User

  @doc """
  Cria um usuário no banco de dados a partir de um mapa de atributos.

  ## Exemplos

      iex> create_user(%{email: "valid@email.com", password: "123456"})
      {:ok, %User{}}

      iex> create_user(%{email: "bad", password: "123"})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_user(map()) :: {:ok, %User{}} | {:error, Ecto.Changeset.t()}
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
