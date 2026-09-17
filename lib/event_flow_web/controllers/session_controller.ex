defmodule EventFlowWeb.SessionController do
  use EventFlowWeb, :controller

  alias EventFlow.Accounts
  alias EventFlowWeb.Auth.Token

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Token.generate_and_sign(%{"user_id" => user.id})

          conn
          |> put_status(:ok)
          |> render(:show, user: user, token: token)

      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Credenciais inválidas"})
    end
  end

  def me(conn, _params) do
    user = conn.assigns.current_user

    conn
    |> put_status(:ok)
    |> render(:show, user: user, token: nil)
  end
end
