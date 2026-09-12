defmodule EventFlow.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EventFlowWeb.Telemetry,
      EventFlow.Repo,
      {DNSCluster, query: Application.get_env(:event_flow, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EventFlow.PubSub},
      # Start a worker by calling: EventFlow.Worker.start_link(arg)
      # {EventFlow.Worker, arg},
      # Start to serve requests, typically the last entry
      EventFlowWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EventFlow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EventFlowWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
