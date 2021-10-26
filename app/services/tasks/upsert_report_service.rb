# frozen_string_literal: true

module Tasks
  class UpsertReportService < Tasks::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      upsert_report_request = Tulo::Tasks::V1::UpsertReportRequest.new(
        report: Tulo::Tasks::V1::Report.new(
          id: proto_int64(@request_params.id),
          document_incoming_id: proto_int64(@request_params.document_incoming_id),
          employee_id: proto_int64(@request_params.employee_id),
          role_name: proto_string(@request_params.role_name),
          message: proto_string(@request_params.message),
        )
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.tasks.host,
        Tulo::Tasks::V1::ReportService,
        :UpsertReport,
        upsert_report_request.to_h
      ).message

      set_result(response.report)
    end

    def set_result(report)
      @result = Tasks::ReportModel.new(
        id: report.id&.value,
        document_incoming_id: report.document_incoming_id&.value,
        employee_id: report.employee_id&.value,
        role_name: report.role_name&.value,
        message: report.message&.value,
        created_at: report.created_at&.value,
        updated_at: report.updated_at&.value,
      )
    end
  end
end
