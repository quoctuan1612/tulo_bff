# frozen_string_literal: true

module Common
  class GetUsersService < Common::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::UserService,
        :GetUsers
      ).message

      set_results(response.users)
    end

    def set_results(users)
      @results = Common::UsersModel.new(
        users: users.each_with_object([]) do |user, arr|
          arr << Common::UserModel.new(
            id: user.id&.value,
            employee_id: user.employee_id&.value,
            user_name: user.user_name&.value,
            encrypted_password: user.encrypted_password&.value,
            created_at: user.created_at&.value,
            updated_at: user.updated_at&.value
          )
        end
      )
    end
  end
end
