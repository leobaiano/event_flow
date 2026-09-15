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

  @doc """
  Lista todos os usuários cadastrados

  ## Exmplos

      iex> list_users()]
      {:ok, {%User{}}}

  """
  @spec list_users() :: [%User{}]
  def list_users do
    Repo.all(User)
  end

  @doc """
  Retorna um usuário com base no ID. Retorna %User{} ou nil.

  ## Exemplos

      iex> get_user(1)
      %User{}

      iex> get_user(999)
      nil

  """
  @spec get_user(term()) :: %User{} | nil
  def get_user(id) do
    Repo.get(User, id)
  end

  @doc """
  Deleta um usuário do banco de dados.

  ## Exemplos

      iex> delete_user(user)
      {:ok, %User{}}

  """
  @spec delete_user(%User{}) :: {:ok, %User{}} | {:error, Ecto.Changeset.t()}
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Atualiza dados de um usuário do banco de dados

  ## Exemplos

      iex> update_user(%{id:"1", email: "valid@email.com", password: "123456"})
      {:ok, %User{}}

      iex> update_user(%{id: "1", email: "bad", password: "123"})
      {:error, %Ecto.Changeset{}}
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end
end
