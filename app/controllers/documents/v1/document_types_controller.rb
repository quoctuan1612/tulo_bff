# frozen_string_literal: true

class Documents::V1::DocumentTypesController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  
  def index
    service = Documents::GetDocumentTypesService.new(nil)
    service.run!
    render json: service.results, serializer: Documents::DocumentTypesSerializer, status: :ok
  end

  def show
    request_params = Documents::DocumentTypeIdRequestParams.new(params)
    request_params.validate!
    service = Documents::ShowDocumentTypeService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Documents::DocumentTypeSerializer, status: :ok
  end
end
