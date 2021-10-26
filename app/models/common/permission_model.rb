# frozen_string_literal: true

module Common
  class PermissionModel < ActiveModelSerializers::Model
    attributes :id,
               :role_id,
               :description,
               :created_at,
               :updated_at
  end
end
