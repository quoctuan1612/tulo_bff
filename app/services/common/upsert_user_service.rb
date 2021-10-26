# frozen_string_literal: true

module Common
  class UpsertUserService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Common::V1::UpsertUserRequest.new(
        user: Tulo::Common::V1::User.new(
          id: proto_int64(@request_params.id),
          employee_id: proto_int64(@request_params.employee_id),
          user_name: proto_string(@request_params.user_name),
          encrypted_password: encrypted_password(@request_params.password)
        )
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::UserService,
        :UpsertUser,
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

    def encrypted_password(password)
      password = "#{password}#{Settings.encrypted_password.pepper}" if Settings.encrypted_password.pepper.present?
      proto_string(::BCrypt::Password.create(password, cost: Settings.encrypted_password.stretches).to_s)
    end
  end
end
