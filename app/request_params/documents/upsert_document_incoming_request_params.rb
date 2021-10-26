# frozen_string_literal: true

module Documents
  class UpsertDocumentIncomingRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :document_name, :string
    attribute :document_type_id, :integer
    attribute :document_destination_id, :integer
    attribute :abstract, :string
    attribute :file_path, :string
    attribute :file_name, :string
    attribute :tmp, :string

    validates :document_name, presence: true
    validates :document_type_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :document_destination_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :abstract, presence: true

    def initialize(document_incoming)
      super(
        id: document_incoming[:id],
        document_name: document_incoming[:document_name],
        document_type_id: document_incoming[:document_type_id],
        document_destination_id: document_incoming[:document_destination_id],
        abstract: document_incoming[:abstract],
        file_path: '',
        file_name: document_incoming[:file] == 'null' ? '' : document_incoming[:file]&.original_filename,
        tmp: document_incoming[:file] == 'null' ? '' : document_incoming[:file]&.tempfile&.path
      )
    end
  end
end
