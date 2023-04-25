import Config

config :pandadoc_api, Pandadoc,
  base_url: System.get_env("PANDADOC_BASE_URL", "https://api.pandadoc.com/public/v1")
