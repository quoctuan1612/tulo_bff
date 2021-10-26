# frozen_string_literal: true

module Departments
  class ShowDepartmentService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Departments::V1::DepartmentIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.departments.host,
        Tulo::Departments::V1::DepartmentService,
        :GetDepartmentById,
        request_message.to_h
      ).message

      set_result(response.department)
    end

    def set_result(department)
      @result = Departments::DepartmentModel.new(
        id: department.id&.value,
        department_name: department.department_name&.value,
        parent_department_id: department.parent_department_id&.value,
        mgr_id: department.mgr_id&.value,
        description: department.description&.value,
        created_at: department.created_at&.value,
        updated_at: department.updated_at&.value
      )
    end
  end
end
