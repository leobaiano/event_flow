import Config

# General application configuration
config :event_flow,
  ecto_repos: [EventFlow.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configure the endpoint
config :event_flow, EventFlowWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: EventFlowWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: EventFlow.PubSub,
  live_view: [signing_salt: "t+e4t6lN"]

# Configure the mailer
config :event_flow, EventFlow.Mailer, adapter: Swoosh.Adapters.Local

# Configure Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
