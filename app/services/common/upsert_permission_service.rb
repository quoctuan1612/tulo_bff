# frozen_string_literal: true

module Common
  class UpsertPermissionService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      upsert_permission_request = Tulo::Common::V1::UpsertPermissionRequest.new(
        permission: Tulo::Common::V1::Permission.new(
          id: proto_int64(@request_params.permission.first.id),
          role_id: proto_string(@request_params.permission.first.role_id),
          description: proto_string(@request_params.permission.first.description)
        ),
        permission_details: @request_params.permission_details.each_with_object([]) do |permission_detail, arr|
          arr << Tulo::Common::V1::PermissionDetail.new(
            id: proto_int64(permission_detail.id),
            permission_id: proto_int64(permission_detail.permission_id),
            permission_name: proto_string(permission_detail.permission_name),
            permission: proto_string(permission_detail.permission),
            is_active: proto_bool(permission_detail.is_active)
          )
        end
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::PermissionService,
        :UpsertPermission,
        upsert_permission_request.to_h
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
