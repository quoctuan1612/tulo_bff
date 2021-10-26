# frozen_string_literal: true

class Documents::V1::DocumentsIncomingController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  
  def index
    service = Documents::GetDocumentsIncomingService.new(nil)
    service.run!
    render json: service.results, serializer: Documents::DocumentsIncomingSerializer, status: :ok
  end

  def show
    request_params = Documents::DocumentIncomingIdRequestParams.new(params)
    request_params.validate!
    service = Documents::ShowDocumentIncomingService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Documents::DocumentIncomingSerializer, status: :ok
  end

  def create
    request_params = Documents::UpsertDocumentIncomingRequestParams.new(params)
    request_params.validate!
    service = Documents::UpsertDocumentIncomingService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Documents::DocumentIncomingSerializer, status: :ok
  end

  def destroy
    request_params = Documents::DocumentIncomingIdRequestParams.new(params)
    request_params.validate!
    service = Documents::DeleteDocumentIncomingService.new(request_params, nil)
    service.run!
    render json: { message: service.result }, status: :ok
  end

  def download_file
    file_path = params[:file_path].to_s
    tmp_path = Rails.root.join file_path

    send_file(tmp_path, type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
  end
end
