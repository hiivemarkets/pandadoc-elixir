defmodule Pandadoc.Contacts do
  @moduledoc """
  The `Pandadoc.Contacts` module provides methods for managing contacts
  All methods require a Tesla Client struct created with `Pandadoc.client(api_key)`.

  ## Examples

      client = Pandadoc.Client("thisismykeycreatedinpandadoc")
      {:ok, result, _env} = Pandadoc.Contacts.list_contacts(client)
  """
  @contacts_url "/contacts"

  @type create_contact_attrs :: %{
          email: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          company: String.t(),
          job_title: String.t(),
          phone: String.t(),
          country: String.t(),
          state: String.t(),
          street_address: String.t(),
          city: String.t(),
          postal_code: String.t()
        }

  @doc """
  Create a contact

  https://developers.pandadoc.com/reference/create-contact
  """
  @spec create_contact(Pandadoc.client(), create_contact_attrs()) ::
          Pandadoc.result()
  def create_contact(client, attrs) do
    client
    |> Tesla.post(@contacts_url, attrs)
    |> Pandadoc.result()
  end

  @doc """
  List contacts associated with the workspace

  https://developers.pandadoc.com/reference/list-contacts
  """
  @spec list_contacts(Pandadoc.client(), String.t() | nil) :: Pandadoc.result()
  def list_contacts(client, email \\ nil) do
    url = build_list_contacts_url(email)

    client
    |> Tesla.get(url)
    |> Pandadoc.result()
  end

  @spec build_list_contacts_url(String.t() | nil) :: String.t()
  defp build_list_contacts_url(nil), do: @contacts_url
  defp build_list_contacts_url(email), do: Tesla.build_url(@contacts_url, [email: email])
end
