# frozen_string_literal: true

module Departments
  class GetDepartmentsService < Departments::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.departments.host,
        Tulo::Departments::V1::DepartmentService,
        :GetDepartments
      ).message

      set_results(response.departments)
    end

    def set_results(departments)
      @results = Departments::DepartmentsModel.new(
        departments: departments.each_with_object([]) do |department, arr|
          arr << Departments::DepartmentModel.new(
            id: department.id&.value,
            department_name: department.department_name&.value,
            parent_department_id: department.parent_department_id&.value,
            mgr_id: department.mgr_id&.value,
            description: department.description&.value,
            created_at: department.created_at&.value,
            updated_at: department.updated_at&.value
          )
        end
      )
    end
  end
end
