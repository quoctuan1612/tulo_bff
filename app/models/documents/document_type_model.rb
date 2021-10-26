# frozen_string_literal: true

module Documents
  class DocumentTypeModel < ActiveModelSerializers::Model
    attributes :id,
               :document_type_name,
               :description
  end
end
