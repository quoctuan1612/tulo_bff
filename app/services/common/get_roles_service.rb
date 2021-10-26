# frozen_string_literal: true

module Common
  class GetRolesService < Common::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::RoleService,
        :GetRoles
      ).message

      set_results(response.roles)
    end

    def set_results(roles)
      @results = Common::RolesModel.new(
        roles: roles.each_with_object([]) do |role, arr|
          arr << Common::RoleModel.new(
            id: role.id&.value,
            role_id: role.role_id&.value,
            role_name: role.role_name&.value,
            description: role.description&.value,
            created_at: role.created_at&.value,
            updated_at: role.updated_at&.value
          )
        end
      )
    end
  end
end
