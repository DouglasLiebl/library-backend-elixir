# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :rest_elixir,
  ecto_repos: [RestElixir.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :rest_elixir, RestElixirWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: RestElixirWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: RestElixir.PubSub,
  live_view: [signing_salt: "BiA92gOK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian config
config :rest_elixir, RestElixirWeb.Auth.Guardian,
    issuer: "rest_elixir",
    secret_key: "fLBRF50JGxHnk4xuit8aPXC3TiwXyIKkKI8GCWP2ztViZpGQKbU8SV7xxPjR6M0q"



# Swoosh config
config :rest_elixir, RestElixir.Mailer,
    adapter: Swoosh.Adapters.Gmail,
    access_token: ""
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
