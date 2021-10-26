# frozen_string_literal: true

class Documents::V1::DocumentDestinationsController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  
  def index
    service = Documents::GetDocumentDestinationsService.new(nil)
    service.run!
    render json: service.results, serializer: Documents::DocumentDestinationsSerializer, status: :ok
  end

  def show
    request_params = Documents::DocumentDestinationIdRequestParams.new(params)
    request_params.validate!
    service = Documents::ShowDocumentDestinationService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Documents::DocumentDestinationSerializer, status: :ok
  end

  def create
    request_params = Documents::UpsertDocumentDestinationRequestParams.new(params)
    request_params.validate!
    service = Documents::UpsertDocumentDestinationService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Documents::DocumentDestinationSerializer, status: :ok
  end

  def destroy
    request_params = Documents::DocumentDestinationIdRequestParams.new(params)
    request_params.validate!
    service = Documents::DeleteDocumentDestinationService.new(request_params, nil)
    service.run!
    render json: { message: service.result }, status: :ok
  end
end
