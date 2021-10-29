defmodule Pandadoc.Options.CreateFromTemplate do
@moduledoc """
Structure for creating documents
"""
alias Pandadoc.Options
@fields quote(
  do: [
    folder_uuid: String.t() | nil,
    tags: list(String.t()) | nil,
    recipients: list(Options.Recipient.t()) | nil,
    tokens: list(Options.Token.t()) | nil,
    fields: %{required(String.t()) => Options.Field.t()} | nil,
    metadata: %{required(String.t()) => String.t()} | nil,
    pricing_tables: list(Options.PricingTable.t()) | nil,
    content_placeholders: list(Options.ContentPlaceHolders.t()) | nil,
    images: list(Options.Image.t()) | nil
  ]
)
defstruct Keyword.keys(@fields)

@type t() :: %__MODULE__{unquote_splicing(@fields)}

end

defmodule Pandadoc.Options.CreateFromPDF do
  @moduledoc """
  Structure for creating documents
  """
  alias Pandadoc.Options
  @fields quote(
    do: [
      tags: list(String.t()) | nil,
      recipients: list(Options.Recipient.t()) | nil,
      fields: %{required(String.t()) => Options.Field.t()} | nil,
      parse_form_fields: boolean()
    ]
  )
  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}

  end

defmodule Pandadoc.Options.Token do
  @moduledoc """
  Structure for a token
  """
  @fields quote(
    do: [
      name: String.t(),
      value: String.t()
    ]
  )
  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}

end

defmodule Pandadoc.Options.Field do
  @moduledoc """
  Structure for a field
  """
  @fields quote(
    do: [
      value: String.t(),
      role: String.t() | nil
    ]
  )
  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}

end

defmodule Pandadoc.Options.Recipient do
  @moduledoc """
  Structure for recipients
  """
  @fields quote(
    do: [
      email: String.t(),
      first_name: String.t() | nil,
      last_name: String.t() | nil,
      role: String.t() | nil,
      signing_order: integer() | nil
    ]
  )
  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}

end

defmodule Pandadoc.Options.Image do
  @moduledoc """
  Structure for images
  """
  @fields quote(
    do: [
      name: String.t(),
      urls: list(String.t())
    ]
  )
  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}

end

defmodule Pandadoc.Options.PricingTable do
  @moduledoc """
  Structure for pricingtable
  """
  alias Pandadoc.Options

  @fields quote(
    do: [
      name: String.t(),
      options: map() | nil,
      sections: list(Options.PricingTableSection.t())
    ]
  )
  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}

end

defmodule Pandadoc.Options.PricingTableSection do
  @moduledoc """
  Structure for pricingtable sections
  """
  alias Pandadoc.Options

  @fields quote(
    do: [
      title: String.t(),
      default: boolean(),
      rows: list(Options.PricingTableRow.t())
    ]
  )
  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}

end

defmodule Pandadoc.Options.PricingTableRow do
  @moduledoc """
  Structure for pricingtable rows
  """
  @fields quote(
    do: [
      options: map() | nil,
      data: map() | nil,
      custom_fields:  map() | nil,
    ]
  )
  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}

end

defmodule Pandadoc.Options.ContentPlaceHolders do
  @moduledoc """
  Structure for content placeholders
  """
  @fields quote(
    do: [
      block_id: String.t(),
      content_library_items: list(map()) | nil
    ]
  )
  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}

end
