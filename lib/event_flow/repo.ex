defmodule EventFlow.Repo do
  use Ecto.Repo,
    otp_app: :event_flow,
    adapter: Ecto.Adapters.Postgres
end
