# frozen_string_literal: true

module Documents
  class DocumentDestinationsSerializer < ActiveModel::Serializer
    attributes :document_destinations

    delegate to: :object

    def document_destinations
      object.document_destinations.each_with_object([]) do |document_destination, arr|
        arr << Documents::DocumentDestinationSerializer.new(document_destination)
      end
    end
  end
end
