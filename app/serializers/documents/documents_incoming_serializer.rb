# frozen_string_literal: true

module Documents
  class DocumentsIncomingSerializer < ActiveModel::Serializer
    attributes :documents_incoming

    delegate to: :object

    def documents_incoming
      object.documents_incoming.each_with_object([]) do |document_incoming, arr|
        arr << Documents::DocumentIncomingSerializer.new(document_incoming)
      end
    end
  end
end
