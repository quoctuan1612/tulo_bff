# frozen_string_literal: true

module Common
  class GetPermissionsService < Common::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::PermissionService,
        :GetPermissions
      ).message

      set_results(response.permissions)
    end

    def set_results(permissions)
      @results = Common::PermissionsModel.new(
        permissions: permissions.each_with_object([]) do |permission, arr|
          arr << Common::PermissionModel.new(
            id: permission.id&.value,
            role_id: permission.role_id&.value,
            description: permission.description&.value,
            created_at: permission.created_at&.value,
            updated_at: permission.updated_at&.value
          )
        end
      )
    end
  end
end
