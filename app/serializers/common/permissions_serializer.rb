# frozen_string_literal: true

module Common
  class PermissionsSerializer < ActiveModel::Serializer
    attributes :permissions

    delegate to: :object

    def permissions
      object.permissions.each_with_object([]) do |permission, arr|
        arr << Common::PermissionSerializer.new(permission)
      end
    end
  end
end
