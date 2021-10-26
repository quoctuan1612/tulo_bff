# frozen_string_literal: true

module Documents
  class ProcessingTimeRequestParams < TuloCommon::RequestParamsBase
    attribute :document_type_id, :integer
    attribute :document_destination_id, :integer

    validates :document_type_id,
              :document_destination_id, numericality: { only_integer: true, greater_than: 0 }

    def initialize(params)
      super(
        document_type_id: params[:document_type_id],
        document_destination_id: params[:document_destination_id]
      )
    end
  end
end
