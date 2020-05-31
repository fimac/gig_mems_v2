# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gig_mems_v2,
  ecto_repos: [GigMemsV2.Repo]

# Configures the endpoint
config :gig_mems_v2, GigMemsV2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qeU2rxQNNiXKoQp6KExVK62hBX5fStZ4Jf2hhHGV2uzJB11x4VTfaiV0vZeZHAAA",
  render_errors: [view: GigMemsV2Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GigMemsV2.PubSub,
  live_view: [signing_salt: "TRSInAfS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :gig_mems_v2, :setlist_fm_key, System.get_env("SETLISTFM_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
