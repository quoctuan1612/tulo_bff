# frozen_string_literal: true

module Documents
  class DocumentProcessingTimeModel < ActiveModelSerializers::Model
    attributes :id,
               :document_type_id,
               :document_destination_id,
               :processing_time,
               :created_at,
               :updated_at
  end
end
