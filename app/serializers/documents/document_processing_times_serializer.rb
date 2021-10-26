# frozen_string_literal: true

module Documents
  class DocumentProcessingTimesSerializer < ActiveModel::Serializer
    attributes :document_processing_times

    delegate to: :object

    def document_processing_times
      object.document_processing_times.each_with_object([]) do |document_processing_time, arr|
        arr << Documents::DocumentProcessingTimeSerializer.new(document_processing_time)
      end
    end
  end
end
