# frozen_string_literal: true

module Documents
  class DocumentTypesSerializer < ActiveModel::Serializer
    attributes :document_types

    delegate to: :object

    def document_types
      object.document_types.each_with_object([]) do |document_type, arr|
        arr << Documents::DocumentTypeSerializer.new(document_type)
      end
    end
  end
end
