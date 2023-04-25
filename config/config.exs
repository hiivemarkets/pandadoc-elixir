import Config

env_config = "#{Mix.env()}.exs"
File.exists?("config/#{env_config}") && import_config(env_config)

config :pandadoc_api, Pandadoc,
  base_url: System.get_env("PANDADOC_BASE_URL", "https://api.pandadoc.com/public/v1")
