ExUnit.start()

Mox.defmock(
  Pandadoc.Tesla.Mock,
  for: Tesla.Adapter
)
