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
end
