defmodule EventFlowWeb.SessionController do
  use EventFlowWeb, :controller

  alias EventFlow.Accounts

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render(:show, user: user)

      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Credenciais inválidas"})
    end
  end
end
