defmodule EventFlowWeb.SessionJSON do
  @moduledoc """
  Módulo responsável por formatar a resposta JSON para o recurso Session.
  """
  alias EventFlow.Accounts.User

  @doc """
  Renderiza a resposta de um único usuário autenticado.
  """
  def show(%{user: user, token: token}) do
    %{
      data: data(user, token)
    }
  end

  # Função privada auxiliar para formatar os dados expostos do usuário
  defp data(%User{} = user, token) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end
end
