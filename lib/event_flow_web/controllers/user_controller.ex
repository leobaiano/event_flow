defmodule EventFlowWeb.UserController do
  use EventFlowWeb, :controller

  alias EventFlow.Accounts

  @doc """
  Action para criar um novo usuário via HTTP POST.
  """
  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render(:show, user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, changeset: changeset)
    end
  end

  @doc """
  Action para listar os usuários via HTTP GET.
  """
  def index(conn, _params) do
    users = Accounts.list_users()

    conn
    |> put_status(:ok) # opcional, pois 200 é o padrão
    |> render(:index, users: users)
  end
end
