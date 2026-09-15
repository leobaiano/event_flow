defmodule EventFlowWeb.UserController do
  use EventFlowWeb, :controller

  alias EventFlow.Accounts
  alias EventFlow.Accounts.User

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

  @doc """
  Action para retornar um usuário via HTTP GET pelo ID.
  """
  def show(conn, %{"id" => id}) do
    case Accounts.get_user(id) do
      %User{} = user ->
        conn
        |> put_status(:ok)
        |> render(:show, user: user)

      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Usuário não encontrado"})
    end
  end

  @doc """
  Action para deletar um usuário via HTTP DELETE
  """
  def delete(conn, %{"id" => id}) do
    case Accounts.get_user(id) do
      %User{} = user ->
        {:ok, _deleted_user} = Accounts.delete_user(user)

        conn
        |> put_status(:no_content)
        |> send_resp(:no_content, "")

      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Usuário não encontrado"})
    end

  end

 @doc """
  Action para editar um usuário via HTTP PATCH pelo ID.
  """
  def update(conn, %{"id" => id, "user" => user_params}) do
    case Accounts.get_user(id) do
      %User{} = user ->
        case Accounts.update_user(user, user_params) do
          {:ok, updated_user} ->
            conn
            |> put_status(:ok)
            |> render(:show, user: updated_user)

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(:error, changeset: changeset)
        end

      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Usuário não encontrado"})
    end
  end
end
