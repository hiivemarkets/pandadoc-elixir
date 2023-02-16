defmodule Pandadoc.Templates do
  @moduledoc """
  The `Pandadoc.Templates` module provides access methods to the `templates` API endpoint.
  All methods require a Tesla Client struct created with `Pandadoc.client(api_key)`.

  ## Examples

      client = Pandadoc.Client("thisismykeycreatedinpandadoc")
      {:ok, result, _env} = Pandadoc.Templates.template_details(client, "template_id")
  """

  @templates_url "/templates"

  @doc """
  Return detailed data about a template

  https://developers.pandadoc.com/reference/template-details
  """
  @spec template_details(Pandadoc.client(), String.t()) :: Pandadoc.result()
  def template_details(client, template_id) do
    Tesla.get(client, @templates_url <> "/#{template_id}/details")
    |> Pandadoc.result()
  end
end
