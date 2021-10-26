# frozen_string_literal: true

class Documents::V1::DocumentProcessingTimesController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  
  def index
    service = Documents::GetDocumentProcessingTimesService.new(nil)
    service.run!
    render json: service.results, serializer: Documents::DocumentProcessingTimesSerializer, status: :ok
  end

  def show
    request_params = Documents::DocumentProcessingTimeIdRequestParams.new(params)
    request_params.validate!
    service = Documents::ShowDocumentProcessingTimeService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Documents::DocumentProcessingTimeSerializer, status: :ok
  end

  def create
    request_params = Documents::UpsertDocumentProcessingTimeRequestParams.new(params)
    request_params.validate!
    service = Documents::UpsertDocumentProcessingTimeService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Documents::DocumentProcessingTimeSerializer, status: :ok
  end

  def destroy
    request_params = Documents::DocumentProcessingTimeIdRequestParams.new(params)
    request_params.validate!
    service = Documents::DeleteDocumentProcessingTimeService.new(request_params, nil)
    service.run!
    render json: { message: service.result }, status: :ok
  end

  def get_processing_time
    request_params = Documents::ProcessingTimeRequestParams.new(params)
    request_params.validate!
    service = Documents::GetProcessingTimeService.new(request_params, nil)
    service.run!
    render json: service.result, status: :ok
  end
end
