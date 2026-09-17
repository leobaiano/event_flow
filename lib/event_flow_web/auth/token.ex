defmodule EventFlowWeb.Auth.Token do
  @moduledoc """
  Módulo responsável por assinar e verificar JSON Web Tokens (JWT) usando Joken.
  """
  use Joken.Config

  # Define as reivindicações padrão (default claims) como o tempo de expiração (exp)
  @impl true
  def token_config do
    default_claims(default_exp: 60 * 60 * 24) # Expira em 24 horas (86400 segundos)
  end
end
