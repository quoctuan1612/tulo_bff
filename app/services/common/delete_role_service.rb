# frozen_string_literal: true

module Common
  class DeleteRoleService < Common::ServiceBase
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
        :DeleteRoleById,
        request_message.to_h
      ).message

      @result = response.message&.value
    end
  end
end
