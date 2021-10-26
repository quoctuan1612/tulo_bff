# frozen_string_literal: true

class Tasks::V1::ReportsController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler

  def index
    service = Tasks::GetReportsService.new(auth_header)
    service.run!
    render json: service.results, serializer: Tasks::ReportsSerializer, status: :ok
  end

  def create
    request_params = Tasks::UpsertReportRequestParams.new(params)
    request_params.validate!
    service = Tasks::UpsertReportService.new(request_params, auth_header)
    service.run!
    render json: service.result, serializer: Tasks::ReportSerializer, status: :ok
  end

  def show
    request_params = Tasks::ReportIdRequestParams.new(params)
    request_params.validate!
    service = Tasks::ShowReportService.new(request_params, auth_header)
    service.run!
    render json: service.result, serializer: Tasks::ReportSerializer, status: :ok
  end

  def get_reports_by_document_incoming_id
    request_params = Documents::DocumentIncomingIdRequestParams.new(params)
    request_params.validate!
    service = Tasks::GetReportsByDocumentIncomingIdService.new(request_params, auth_header)
    service.run!
    render json: service.results, serializer: Tasks::ReportsSerializer, status: :ok
  end

  def destroy
    request_params = Tasks::ReportIdRequestParams.new(params)
    request_params.validate!
    service = Tasks::DeleteReportService.new(request_params, auth_header)
    service.run!
    render json: { message: service.result }, status: :ok
  end
end
