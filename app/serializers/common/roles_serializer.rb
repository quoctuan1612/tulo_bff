# frozen_string_literal: true

module Common
  class RolesSerializer < ActiveModel::Serializer
    attributes :roles

    delegate to: :object

    def roles
      object.roles.each_with_object([]) do |role, arr|
        arr << Common::RoleSerializer.new(role)
      end
    end
  end
end
