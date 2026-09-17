defmodule EventFlowWeb.Router do
  use EventFlowWeb, :router

  # Pipeline básico para respostas em JSON
  pipeline :api do
    plug :accepts, ["json"]
  end

  # Pipeline privado que exige token JWT válido
  pipeline :authenticated_api do
    plug :accepts, ["json"]
    plug EventFlowWeb.Plugs.Authenticate
  end

  # Rotas PÚBLICAS (não exigem autenticação)
  scope "/api", EventFlowWeb do
    pipe_through :api

    post "/users", UserController, :create
    post "/sessions", SessionController, :create
  end

  # Rotas PROTEGIDAS (exigem token JWT no cabeçalho)
  scope "/api", EventFlowWeb do
    pipe_through :authenticated_api

    # Consulta dos dados do usuário logado
    get "/me", SessionController, :me

    # Gestão de usuários
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    delete "/users/:id", UserController, :delete
    patch "/users/:id", UserController, :update
  end

  # Dashboard e Mailbox em ambiente de desenvolvimento
  if Application.compile_env(:event_flow, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: EventFlowWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
