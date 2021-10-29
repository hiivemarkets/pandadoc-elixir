# Pandadoc

This library provides an Elixir API for accessing the [Pandadoc Developer APIs](https://developers.pandadoc.com/reference/about).

![](https://github.com/hiivemarkets/pandadoc-elixir/workflows/Elixir%20CI/badge.svg)

The API access uses the [Tesla](https://github.com/teamon/tesla) library and
relies on the caller passing in an an API Key to create a
client. The client is then passed into all API calls.

The API returns a 3 element tuple. If the API HTTP status code is less
the 300 (ie. suceeded) it returns `:ok`, the HTTP body as a map and the full
Tesla Env if you need to access more data about thre return. if the API HTTP
status code is greater than 300. it returns `:error`, the HTTP body and the
Telsa Env. If the API doesn't return at all it should return `:error`, a blank
map and the error from Tesla.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be
installed by adding `pandadoc_api` to your list of dependencies in `mix.exs`:

      def deps do
        [
          {:pandadoc_api, "~> 0.0.1"},
        ]
      end

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/pandadoc_api](https://hexdocs.pm/pandadoc_api).
