defmodule Pandadoc do
  @moduledoc """
  Elixir wrapper for the Pandadoc API

  ## Installation

  If [available in Hex](https://hex.pm/docs/publish), the package can be
  installed by adding `okta` to your list of dependencies in `mix.exs`:

      def deps do
        [
          {:pandadoc_api, "~> 0.0.1"},
        ]
      end

  Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
  and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
  be found at [https://hexdocs.pm/pandadoc_api](https://hexdocs.pm/pandadoc_api).
  """
  @type client() :: Tesla.Client.t()
  @type result() :: {:ok, map() | String.t(), Tesla.Env.t()} | {:error, map(), any}

  @spec client(String.t()) :: client()
  def client(api_key) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.pandadoc.com/public/v1"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"authorization", "API-Key " <> api_key}]}
    ]

    Tesla.client(middleware, adapter())
  end

  @spec result({:ok, Tesla.Env.t()}) :: result()
  def result({:ok, %{status: status, body: body} = env}) when status < 300 do
    {:ok, body, env}
  end

  @spec result({:ok, Tesla.Env.t()}) :: result()
  def result({:ok, %{status: status, body: body} = env}) when status >= 300 do
    {:error, body, env}
  end

  @spec result({:error, any}) :: result()
  def result({:error, any}), do: {:error, %{}, any}

  @doc false
  def adapter do
    case Application.get_env(:pandadoc_api, :tesla) do
      nil -> {Tesla.Adapter.Hackney, [recv_timeout: 30_000]}
      tesla -> tesla[:adapter]
    end
  end
end
