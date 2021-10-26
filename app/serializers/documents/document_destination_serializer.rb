# frozen_string_literal: true

module Documents
  class DocumentDestinationSerializer < ActiveModel::Serializer
    attributes :id,
               :document_destination_name,
               :email,
               :phone,
               :description,
               :created_at,
               :updated_at
    delegate :id,
             :document_destination_name,
             :email,
             :phone,
             :description,
             :created_at,
             :updated_at, to: :object
  end
end
