# frozen_string_literal: true

module Common
  class RoleSerializer < ActiveModel::Serializer
    attributes :id,
               :role_id,
               :role_name,
               :description,
               :created_at,
               :updated_at
    delegate :id,
             :role_id,
             :role_name,
             :description,
             :created_at,
             :updated_at, to: :object
  end
end
