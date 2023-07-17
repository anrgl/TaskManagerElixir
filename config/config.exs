# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :task_manager,
  ecto_repos: [TaskManager.Repo]

# Configures the endpoint
config :task_manager, TaskManagerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: TaskManagerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TaskManager.PubSub,
  live_view: [signing_salt: "P4U8VMqh"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :task_manager, TaskManager.Mailer, adapter: Swoosh.Adapters.Local
config :task_manager, :mailer, email_from: "admin@localhost.com"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :task_manager, env: config_env()

config :task_manager, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: TaskManagerWeb.Router,
      endpoint: TaskManagerWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason

config :task_manager, TaskManager.Guardian,
  issuer: "task_manager",
  secret_key: "f6SWKek9Orqut/9szsekFhf/wo+kCUfFoSvyXAQwAEw/VkpIRwryPo/tNnQvJLkp"
