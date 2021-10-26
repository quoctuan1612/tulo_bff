# frozen_string_literal: true

module Common
  class PermissionDetailRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :permission_id, :integer
    attribute :permission_name, :string
    attribute :permission, :string
    attribute :is_active, :boolean

    validates :permission_name, presence: true
    validates :permission, presence: true
    validates :is_active, inclusion: { in: [true, false] }

    def initialize(permission_detail)
      super(
        id: permission_detail[:id],
        permission_id: permission_detail[:permission_id],
        permission_name: permission_detail[:permission_name],
        permission: permission_detail[:permission],
        is_active: permission_detail[:is_active],
      )
    end
  end
end
