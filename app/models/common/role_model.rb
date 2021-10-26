# frozen_string_literal: true

module Common
  class RoleModel < ActiveModelSerializers::Model
    attributes :id,
               :role_id,
               :role_name,
               :description,
               :created_at,
               :updated_at
  end
end
