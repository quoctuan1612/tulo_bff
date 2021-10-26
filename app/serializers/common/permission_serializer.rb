# frozen_string_literal: true

module Common
  class PermissionSerializer < ActiveModel::Serializer
    attributes :id,
               :role_id,
               :description,
               :created_at,
               :updated_at
    delegate :id,
             :role_id,
             :description,
             :created_at,
             :updated_at, to: :object
  end
end
