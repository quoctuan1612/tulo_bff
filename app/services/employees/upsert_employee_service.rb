# frozen_string_literal: true

module Employees
  class UpsertEmployeeService < Employees::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      upsert_employee_request = Tulo::Employees::V1::UpsertEmployeeRequest.new(
        employee: Tulo::Employees::V1::Employee.new(
          id: proto_int64(@request_params.id),
          first_name: proto_string(@request_params.first_name),
          last_name: proto_string(@request_params.last_name),
          gender: proto_string(@request_params.gender),
          dob: proto_string(@request_params.dob),
          email: proto_string(@request_params.email),
          phone: proto_string(@request_params.phone),
          master_country_id: proto_int64(@request_params.master_country_id),
          master_province_id: proto_int64(@request_params.master_province_id),
          master_district_id: proto_int64(@request_params.master_district_id),
          master_ward_id: proto_int64(@request_params.master_ward_id),
          owner_id: proto_int64(@request_params.owner_id),
          department_id: proto_int64(@request_params.department_id),
          role_id: proto_string(@request_params.role_id)
        )
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.employees.host,
        Tulo::Employees::V1::EmployeeService,
        :UpsertEmployee,
        upsert_employee_request.to_h
      ).message

      set_result(response.employee)
    end

    def set_result(employee)
      @result = Employees::EmployeeModel.new(
        id: employee.id&.value,
        first_name: employee.first_name&.value,
        last_name: employee.last_name&.value,
        gender: employee.gender&.value,
        dob: employee.dob&.value,
        email: employee.email&.value,
        phone: employee.phone&.value,
        master_country_id: employee.master_country_id&.value,
        master_province_id: employee.master_province_id&.value,
        master_district_id: employee.master_district_id&.value,
        master_ward_id: employee.master_ward_id&.value,
        owner_id: employee.owner_id&.value,
        department_id: employee.department_id&.value,
        role_id: employee.role_id&.value,
        created_at: employee.created_at&.value,
        updated_at: employee.updated_at&.value
      )
    end
  end
end
