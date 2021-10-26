# frozen_string_literal: true

module Departments
  class DeleteDepartmentService < Departments::ServiceBase
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
        :DeleteDepartmentById,
        request_message.to_h
      ).message

      @result = response.message&.value
    end
  end
end
