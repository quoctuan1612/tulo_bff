# frozen_string_literal: true

module Employees
  class GetEmployeesService < Employees::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.employees.host,
        Tulo::Employees::V1::EmployeeService,
        :GetEmployees
      ).message

      set_results(response.employees)
    end

    def set_results(employees)
      @results = Employees::EmployeesModel.new(
        employees: employees.each_with_object([]) do |employee, arr|
          arr << Employees::EmployeeModel.new(
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
      )
    end
  end
end
