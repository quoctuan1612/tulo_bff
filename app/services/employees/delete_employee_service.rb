# frozen_string_literal: true

module Employees
  class DeleteEmployeeService < Employees::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Employees::V1::EmployeeIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.employees.host,
        Tulo::Employees::V1::EmployeeService,
        :DeleteEmployeeById,
        request_message.to_h
      ).message

      @result = response.message&.value
    end
  end
end
