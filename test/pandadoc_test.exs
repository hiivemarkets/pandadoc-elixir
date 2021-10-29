defmodule PandadocTest do
  use ExUnit.Case
  doctest Pandadoc

  test "client has correct headerss" do
    api_key = "akey"
    client = Pandadoc.client(api_key)

    assert client.pre == [
             {Tesla.Middleware.BaseUrl, :call, ["https://api.pandadoc.com/public/v1"]},
             {Tesla.Middleware.JSON, :call, [[]]},
             {Tesla.Middleware.Headers, :call, [[{"authorization", "API-Key #{api_key}"}]]}
           ]
  end

  test "results under 300 status are ok" do
    body = %{body: "1"}
    env = %Tesla.Env{status: 200, body: body}

    assert {:ok, %{body: _}, %Tesla.Env{}} = Pandadoc.result({:ok, env})
  end

  test "results over 300 status are not ok" do
    body = %{body: "1"}
    env = %Tesla.Env{status: 400, body: body}

    assert {:error, %{body: _}, %Tesla.Env{}} = Pandadoc.result({:ok, env})
  end

  test "results that fail are not ok" do
    assert {:error, %{}, _} = Pandadoc.result({:error, ""})
  end
end
