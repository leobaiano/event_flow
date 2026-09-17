defmodule EventFlowWeb.Plugs.Authenticate do
  @moduledoc """
  Plug responsável por validar o token JWT e injetar o usuário na conexão.
  """
  import Plug.Conn
  import Phoenix.Controller

  alias EventFlow.Accounts
  alias EventFlowWeb.Auth.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, claims} <- Token.verify_and_validate(token),
         user when not is_nil(user) <- Accounts.get_user(claims["user_id"]) do
      assign(conn, :current_user, user)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> put_view(json: EventFlowWeb.SessionJSON)
        |> render(:error, message: "Acesso não autorizado")
        |> halt()
    end
  end
end
