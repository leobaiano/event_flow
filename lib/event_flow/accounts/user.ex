defmodule EventFlow.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps(type: :utc_datetime)
  end

  @doc """
  Changeset responsável por validar os dados para a criação de um novo usuário.
  """
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "deve ter um formato de e-mail válido")
    |> validate_length(:password, min: 6, message: "deve ter pelo menos 6 caracteres")
    |> put_pass_hash()
  end

  # Função privada para criptografar a senha
  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    # Por enquanto, utilizaremos uma simulação de hash funcional.
    # Na etapa de autenticação completa, utilizaremos o Bcrypt.
    change(changeset, password_hash: "hash_simulado_#{password}")
  end

  defp put_pass_hash(changeset), do: changeset
end
