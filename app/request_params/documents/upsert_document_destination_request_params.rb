# frozen_string_literal: true

module Documents
  class UpsertDocumentDestinationRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :document_destination_name, :string
    attribute :email, :string
    attribute :phone, :string
    attribute :description, :string

    validates :document_destination_name, presence: true

    def initialize(document_destination)
      super(
        id: document_destination[:id],
        document_destination_name: document_destination[:document_destination_name],
        email: document_destination[:email],
        phone: document_destination[:phone],
        description: document_destination[:description]
      )
    end
  end
end
