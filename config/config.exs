# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :canary,
  ecto_repos: [Canary.Repo]

# Configures the endpoint
config :canary, Canary.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UoUTjG0Tsk09Kd7lA55O9qKkGvFOlL6ngYqQJq7JQGss716m+wAdrEg9c6C1aGBD",
  render_errors: [view: Canary.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Canary.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
