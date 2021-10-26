# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: tulo/employees/v1/employee.proto for package 'tulo.employees.v1'

require 'grpc'
require 'tulo/employees/v1/employee_pb'

module Tulo
  module Employees
    module V1
      module EmployeeService
        class Service

          include ::GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'tulo.employees.v1.EmployeeService'

          rpc :GetEmployees, ::Google::Protobuf::Empty, ::Tulo::Employees::V1::EmployeesResponse
          rpc :UpsertEmployee, ::Tulo::Employees::V1::UpsertEmployeeRequest, ::Tulo::Employees::V1::UpsertEmployeeResponse
          rpc :GetEmployeeById, ::Tulo::Employees::V1::EmployeeIdRequest, ::Tulo::Employees::V1::EmployeeResponse
          rpc :DeleteEmployeeById, ::Tulo::Employees::V1::EmployeeIdRequest, ::Tulo::Common::V1::CommonDeleteResponse
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
