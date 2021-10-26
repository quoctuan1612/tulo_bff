# frozen_string_literal: true

module Documents
  class UpsertDocumentProcessingTimeRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :document_type_id, :integer
    attribute :document_destination_id, :integer
    attribute :processing_time, :integer

    validates :document_type_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :document_destination_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :processing_time, presence: true, numericality: { only_integer: true, greater_than: 0 }

    def initialize(document_processing_time)
      super(
        id: document_processing_time[:id],
        document_type_id: document_processing_time[:document_type_id],
        document_destination_id: document_processing_time[:document_destination_id],
        processing_time: document_processing_time[:processing_time]
      )
    end
  end
end
