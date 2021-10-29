import Config

config :pandadoc_api, :tesla, adapter: Pandadoc.Tesla.Mock

config :plug, validate_header_keys_during_test: false
