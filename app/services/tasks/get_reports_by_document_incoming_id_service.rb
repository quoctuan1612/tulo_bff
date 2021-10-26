# frozen_string_literal: true

module Tasks
  class GetReportsByDocumentIncomingIdService < Common::ServiceBase
    attr_reader :results

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Tasks::V1::DocumentIncomingIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.tasks.host,
        Tulo::Tasks::V1::ReportService,
        :GetReportByDocumentIncomingId,
        request_message.to_h
      ).message

      set_results(response.reports)
    end

    def set_results(reports)
      @results = Tasks::ReportsModel.new(
        reports: reports.each_with_object([]) do |report, arr|
          arr << Tasks::ReportModel.new(
            id: report.id&.value,
            document_incoming_id: report.document_incoming_id&.value,
            employee_id: report.employee_id&.value,
            role_name: report.role_name&.value,
            message: report.message&.value,
            created_at: report.created_at&.value,
            updated_at: report.updated_at&.value,
          )
        end
      )
    end
  end
end
