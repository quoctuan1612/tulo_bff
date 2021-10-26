# frozen_string_literal: true

module Common
  class UpsertRoleService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Common::V1::UpsertRoleRequest.new(
        role: Tulo::Common::V1::Role.new(
          id: proto_int64(@request_params.id),
          role_id: proto_string(@request_params.role_id),
          role_name: proto_string(@request_params.role_name),
          description: proto_string(@request_params.description)
        )
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::RoleService,
        :UpsertRole,
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
