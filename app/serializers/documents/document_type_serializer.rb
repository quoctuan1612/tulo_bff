# frozen_string_literal: true

module Documents
  class DocumentTypeSerializer < ActiveModel::Serializer
    attributes :id,
               :document_type_name,
               :description
    delegate :id,
             :document_type_name,
             :description, to: :object
  end
end
