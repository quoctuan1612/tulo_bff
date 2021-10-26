# frozen_string_literal: true

module Documents
  class DocumentDestinationModel < ActiveModelSerializers::Model
    attributes :id,
               :document_destination_name,
               :email,
               :phone,
               :description,
               :created_at,
               :updated_at
  end
end
