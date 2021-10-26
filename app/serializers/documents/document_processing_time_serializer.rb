# frozen_string_literal: true

module Documents
  class DocumentProcessingTimeSerializer < ActiveModel::Serializer
    attributes :id,
               :document_type_id,
               :document_destination_id,
               :processing_time,
               :created_at,
               :updated_at
    delegate :id,
             :document_type_id,
             :document_destination_id,
             :processing_time,
             :created_at,
             :updated_at, to: :object
  end
end
