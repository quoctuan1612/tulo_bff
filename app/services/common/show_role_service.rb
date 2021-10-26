# frozen_string_literal: true

module Common
  class ShowRoleService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Common::V1::RoleIdRequest.new(
        role_id: proto_string(@request_params.role_id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::RoleService,
        :GetRoleById,
        request_message.to_h
      ).message

      set_result(response.role)
    end

    def set_result(role)
      @result = Common::RoleModel.new(
        id: role.id&.value,
        role_id: role.role_id&.value,
        role_name: role.role_name&.value,
        description: role.description&.value,
        created_at: role.created_at&.value,
        updated_at: role.updated_at&.value
      )
    end
  end
end
