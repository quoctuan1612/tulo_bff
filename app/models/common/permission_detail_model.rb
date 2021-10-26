# frozen_string_literal: true

module Common
  class PermissionDetailModel < ActiveModelSerializers::Model
    attributes :id,
               :permission_id,
               :permission_name,
               :permission,
               :is_active,
               :created_at,
               :updated_at
  end
end
