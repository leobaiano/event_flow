defmodule EventFlowWeb.SessionControllerTest do
  use EventFlowWeb.ConnCase, async: true

  alias EventFlow.Accounts

  @valid_attributes %{
    email: "usuario_teste@eventflow.com",
    password: "senha_segura_123"
  }

  setup do
    {:ok, user} = Accounts.create_user(@valid_attributes)
    %{user: user}
  end

  describe "POST /api/sessions (login)" do
    test "retorna 200 OK e os dados do usuário quando as credenciais são válidas", %{conn: conn, user: user} do
      conn = post(conn, ~p"/api/sessions", %{
        "email" => user.email,
        "password" => "senha_segura_123"
      })

      assert %{
               "data" => %{
                 "id" => id,
                 "email" => email
               }
             } = json_response(conn, 200)

      assert id == user.id
      assert email == user.email
    end

    test "retorna 401 Unauthorized quando a senha está incorreta", %{conn: conn, user: user} do
      conn = post(conn, ~p"/api/sessions", %{
        "email" => user.email,
        "password" => "senha_errada"
      })

      assert json_response(conn, 401) == %{"error" => "Credenciais inválidas"}
    end

    test "retorna 401 Unauthorized quando o e-mail não existe no banco", %{conn: conn} do
      conn = post(conn, ~p"/api/sessions", %{
        "email" => "nao_existe@eventflow.com",
        "password" => "senha_qualquer"
      })

      assert json_response(conn, 401) == %{"error" => "Credenciais inválidas"}
    end
  end
end
