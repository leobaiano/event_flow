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
    |> unique_constraint(:email, message: "e-mail já cadastrado")
    |> put_pass_hash()
  end

  # Changeset de atualização (exige apenas email)
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email, message: "já está em uso por outro usuário")
    |> put_pass_hash()
  end

  # Função privada para criptografar a senha
  defp put_pass_hash(changeset) do
    case fetch_change(changeset, :password) do
      {:ok, password} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))

      :error ->
        changeset
    end
  end
end
