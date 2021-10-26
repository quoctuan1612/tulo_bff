# frozen_string_literal: true

module Common
  class UserLoginService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Common::V1::LoginInfoRequest.new(
        user_info: proto_string(@request_params.user_info)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::UserService,
        :UserLogin,
        request_message.to_h
      ).message

      raise TuloCommon::RequestParamsBase::InvalidRequestParams, OpenStruct.new(messages: { password: I18n.t('errors.messages.user.invalid_password') }) unless is_authentication?(response.encrypted_password&.value)

      set_result(response)
    rescue Gruf::Client::Errors::NotFound => e
      raise TuloCommon::RequestParamsBase::InvalidRequestParams, OpenStruct.new(messages: { user_name: e.error['message'] })
    end

    def set_result(response)
      payload = {
        params: {
          employee_id: response.employee_id&.value,
          user_name: response.user_name&.value,
          employee_name: response.employee_name&.value,
          email: response.email&.value,
          phone: response.phone&.value,
          role_id: response.role_id&.value,
          department_id: response.department_id&.value,
          right_to_do: permission_format(response.right_to_do)
        }
      }

      @result = {
        user: {
          employee_id: response.employee_id&.value,
          user_name: response.user_name&.value,
          employee_name: response.employee_name&.value,
          email: response.email&.value,
          phone: response.phone&.value,
          role_id: response.role_id&.value,
          department_id: response.department_id&.value,
          auth_token: (JWT.encode payload, nil, 'none')
        }
      }
    end

    def is_authentication?(encrypted_password)
      return false if encrypted_password.blank?

      bcrypt = BCrypt::Password.new(encrypted_password)

      password = @request_params.password
      password = "#{password}#{Settings.encrypted_password.pepper}" if Settings.encrypted_password.pepper.present?
      password = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)

      return true if password == encrypted_password

      false
    end

    def permission_format(permissions)
      permissions.each_with_object([]) do |permission, arr|
        arr << OpenStruct.new(
          permission_name: permission.permission_name&.value,
          permission: permission.permission&.value,
          is_active: permission.is_active&.value
        )
      end
    end
  end
end
