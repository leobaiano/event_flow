import Config

# Configure your database
config :event_flow, EventFlow.Repo,
  username: "event_flow",
  password: "devlb2005",
  hostname: "localhost",
  database: "event_flow_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
config :event_flow, EventFlowWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "tLxs6xmLay2CYnMhbvjVxa2vKTjYEegkeLxR+aT3nj08X+G0bXw7ynuN2WIBKZ0p",
  watchers: []

# Enable dev routes for dashboard and mailbox
config :event_flow, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :default_formatter, format: "[$level] $message\n"

# Set a higher stacktrace during development.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false
