# frozen_string_literal: true

module Common
  class UpsertPermissionRequestParams < TuloCommon::RequestParamsBase
    include ::NestedValidatable

    VALIDATE_ATTRIBUTES = %i[
      permission
      permission_details
    ].freeze

    attribute :permission
    attribute :permission_details

    validates :permission, presence: true
    validates :permission_details, presence: true

    def initialize(params)
      permission = get_permission(params[:permission])
      permission_details = get_permission_details(params[:permission_details])

      super(
        permission: permission,
        permission_details: permission_details
      )
    end

    private

    def get_permission_details(permission_details)
      permission_details.each_with_object([]) do |permission_detail, arr|
        arr << Common::PermissionDetailRequestParams.new(permission_detail)
      end
    end

    def get_permission(permission)
      permission.each_with_object([]) do |value, arr|
        arr << Common::PermissionRequestParams.new(value)
      end
    end
  end
end
