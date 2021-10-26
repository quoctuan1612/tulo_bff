# frozen_string_literal: true

module Common
  class ShowUserService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Common::V1::UserIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::UserService,
        :GetUserById,
        request_message.to_h
      ).message

      set_result(response.user)
    end

    def set_result(user)
      @result = Common::UserModel.new(
        id: user.id&.value,
        employee_id: user.employee_id&.value,
        user_name: user.user_name&.value,
        encrypted_password: user.encrypted_password&.value,
        created_at: user.created_at&.value,
        updated_at: user.updated_at&.value
      )
    end
  end
end
