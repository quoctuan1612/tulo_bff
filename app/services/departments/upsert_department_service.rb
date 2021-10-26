# frozen_string_literal: true

module Departments
  class UpsertDepartmentService < Departments::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      upsert_department_request = Tulo::Departments::V1::UpsertDepartmentRequest.new(
        department: Tulo::Departments::V1::Department.new(
          id: proto_int64(@request_params.id),
          department_name: proto_string(@request_params.department_name),
          parent_department_id: proto_int64(@request_params.parent_department_id),
          mgr_id: proto_int64(@request_params.mgr_id),
          description: proto_string(@request_params.description)
        )
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.departments.host,
        Tulo::Departments::V1::DepartmentService,
        :UpsertDepartment,
        upsert_department_request.to_h
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
