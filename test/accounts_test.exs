defmodule EventFlow.AccountsTest do
  use EventFlow.DataCase, async: true

  alias EventFlow.Accounts
  alias EventFlow.Accounts.User

  describe "users" do
    @valid_attrs %{email: "teste@eventflow.com", password: "senha_segura_123"}
    @update_attrs %{email: "editado@eventflow.com"}
    @invalid_attrs %{email: "email_invalido", password: "123"}

    # Helper para criar um usuário padrão nos testes
    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      # Limpamos o campo virtual para refletir o estado de um registro vindo do banco
      %{user | password: nil}
    end

    test "list_users/0 retorna todos os usuários cadastrados" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user/1 retorna o usuário correto pelo ID" do
      user = user_fixture()
      assert Accounts.get_user(user.id) == user
    end

    test "get_user/1 retorna nil quando o ID não existe" do
      assert Accounts.get_user(999_999) == nil
    end

    test "create_user/1 com dados válidos cria um usuário e criptografa a senha" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "teste@eventflow.com"
      assert Bcrypt.verify_pass("senha_segura_123", user.password_hash)
    end

    test "create_user/1 com dados inválidos retorna changeset com erro" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 com dados válidos atualiza apenas o e-mail" do
      user = user_fixture()
      assert {:ok, %User{} = updated_user} = Accounts.update_user(user, @update_attrs)
      assert updated_user.email == "editado@eventflow.com"
    end

    test "delete_user/1 remove o usuário do banco" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert Accounts.get_user(user.id) == nil
    end
  end
end
