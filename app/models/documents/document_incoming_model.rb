# frozen_string_literal: true

module Documents
  class DocumentIncomingModel < ActiveModelSerializers::Model
    attributes :id,
               :document_name,
               :document_type_id,
               :document_destination_id,
               :abstract,
               :file_path,
               :file_name,
               :created_at,
               :updated_at
  end
end
