defmodule Pandadoc.Documents do
  @moduledoc """
  The `Pandadoc.Documents` module provides access methods to the
  All methods require a Tesla Client struct created with `Pandadoc.client(api_key)`.

  ## Examples

      client = Pandadoc.Client("thisismykeycreatedinpandadoc")
      {:ok, result, _env} = Okta.Users.list_users(client)
  """

  @documents_url "/documents"

  alias Pandadoc.Options.{CreateFromTemplate, CreateFromPDF}
  alias Tesla.Multipart
  import Pandadoc.Utils

  @doc """
  Create document from Template

  https://developers.pandadoc.com/reference/new-document#create-document-from-pandadoc-template
  """
  @spec create_document_from_template(Pandadoc.client(), String.t(), String.t(), CreateFromTemplate.t()) :: Pandadoc.result()
  def create_document_from_template(client, name, template_uuid, %CreateFromTemplate{} = opts \\ %CreateFromTemplate{}) do
    body =
      opts
      |> stringify_keys()
      |> Map.merge(%{"name" => name, "template_uuid" => template_uuid})

    Tesla.post(client, @documents_url, body)
    |> Pandadoc.result()
  end

  @doc """
  Create document from PDF

  https://developers.pandadoc.com/reference/new-document#create-document-from-pdf
  """
  @spec create_document_from_pdf(Pandadoc.client(), binary(), String.t(), CreateFromPDF.t()) :: Pandadoc.result()
  def create_document_from_pdf(client, name, pdf, %CreateFromPDF{} = opts \\ %CreateFromPDF{parse_form_fields: false}) do
    data =
      opts
      |> stringify_keys()
      |> Map.merge(%{"name" => name})

    mp =
      Multipart.new()
      |> Multipart.add_content_type_param("charset=utf-8")
      |> Multipart.add_field("data", data)
      |> Multipart.add_file_content(pdf, name,
        headers: [{"content-type", "application/pdf"}]
      )

    Tesla.post(client, @documents_url, mp)
    |> Pandadoc.result()
  end

  @doc """
  Create document from URL

  https://developers.pandadoc.com/reference/new-document#create-document-from-pdf
  """
  @spec create_document_from_url(Pandadoc.client(), binary(), String.t(), CreateFromPDF.t()) :: Pandadoc.result()
  def create_document_from_url(client, name, url, %CreateFromPDF{} = opts \\ %CreateFromPDF{parse_form_fields: false}) do
    data =
      opts
      |> stringify_keys()
      |> Map.merge(%{"name" => name, "url" => url})

    mp =
      Multipart.new()
      |> Multipart.add_content_type_param("charset=utf-8")
      |> Multipart.add_field("data", data)
      |> Multipart.add_file_content("", name,
        headers: [{"content-type", "application/pdf"}]
      )

    Tesla.post(client, @documents_url, mp)
    |> Pandadoc.result()
  end


  @doc """

  https://developers.pandadoc.com/reference/list-documents

  ##Example

      {:ok, result} = Pandadoc.Documents.list_documents(client, q: "Noah", count: 10, page: 2)

  """
  @spec list_documents(Panadadoc.client(), keyword()) :: Pandadoc.result()
  def list_documents(client, opts \\ []) do
    Tesla.get(client, @documents_url, query: opts) |> Pandadoc.result()
  end

  @doc """
  Get basic data about a document such as name, status, and dates

  https://developers.pandadoc.com/reference/document-status
  """
  @spec document_status(Pandadoc.client(), String.t()) :: Pandadoc.result()
  def document_status(client, doc_id) do
    Tesla.get(client, @documents_url <> "/#{doc_id}")
    |> Pandadoc.result()
  end

  @doc """
  Return detailed data about a document
  https://developers.pandadoc.com/reference/document-details
  """
  @spec document_details(Pandadoc.client(), String.t()) :: Pandadoc.result()
  def document_details(client, doc_id) do
    Tesla.get(client, @documents_url <> "/#{doc_id}/details")
    |> Pandadoc.result()
  end

  @doc """
  Move a document to sent status and send an optional email.

  https://developers.pandadoc.com/reference/send-document
  """
  @spec send_document(Pandadoc.client(), String.t(), keyword()) :: Pandadoc.result()
  def send_document(client, doc_id, opts \\ [silent: true]) do
    body = opts |> Enum.into(%{}) |> stringify_keys()
    Tesla.post(client, @documents_url <> "/#{doc_id}/send", body)
    |> Pandadoc.result()
  end

  @doc """
  Generate and share a URL link to the document.

  https://developers.pandadoc.com/reference/share-document
  """
  @spec share_document(Pandadoc.client(), String.t(), String.t(), keyword()) :: Pandadoc.result()
  def share_document(client, doc_id, recipient, opts \\ []) do
    body = opts |> Enum.into(%{recipient: recipient}) |> stringify_keys()
    Tesla.post(client, @documents_url <> "/#{doc_id}/session", body)
    |> Pandadoc.result()
  end

  @doc """
  Download a PDF of any document

  https://developers.pandadoc.com/reference/download-document
  """
  @spec download_document(Pandadoc.client(), String.t(), keyword()) :: Pandadoc.result()
  def download_document(client, doc_id, opts \\ []) do
    Tesla.get(client, @documents_url <> "/#{doc_id}/download", query: opts)
    |> Pandadoc.result()
  end

  @doc """
  Download a signed PDF of a completed document

  https://developers.pandadoc.com/reference/download-protected-document
  """
  @spec download_protected_document(Pandadoc.client(), String.t(), keyword()) :: Pandadoc.result()
  def download_protected_document(client, doc_id, opts \\ []) do
    Tesla.get(client, @documents_url <> "/#{doc_id}/download-protected", query: opts)
    |> Pandadoc.result()
  end

  @doc """
  Delete a document

  https://developers.pandadoc.com/reference/delete-document
  """
  @spec delete_document(Pandadoc.client(), String.t()) :: Pandadoc.result()
  def delete_document(client, doc_id) do
    Tesla.delete(client, @documents_url <> "/#{doc_id}")
    |> Pandadoc.result()
  end

end
