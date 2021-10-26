# frozen_string_literal: true

module Common
  class ShowPermissionService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Common::V1::PermissionIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::PermissionService,
        :GetPermissionById,
        request_message.to_h
      ).message

      set_results(response)
    end

    def set_results(response)
      @result = {
        permission: Common::PermissionModel.new(
          id: response.permission.id&.value,
          role_id: response.permission.role_id&.value,
          description: response.permission.description&.value,
          created_at: response.permission.created_at&.value,
          updated_at: response.permission.updated_at&.value
        ),
        permission_details: response.permission_details.each_with_object([]) do |permission_detail, arr|
          arr << Common::PermissionDetailModel.new(
            id: permission_detail.id&.value,
            permission_id: permission_detail.permission_id&.value,
            permission_name: permission_detail.permission_name&.value,
            permission: permission_detail.permission&.value,
            is_active: permission_detail.is_active&.value,
            created_at: permission_detail.created_at&.value,
            updated_at: permission_detail.updated_at&.value
          )
        end
      }
    end
  end
end
