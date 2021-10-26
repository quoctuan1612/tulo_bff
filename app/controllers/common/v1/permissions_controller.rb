# frozen_string_literal: true

class Common::V1::PermissionsController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  
  def index
    service = Common::GetPermissionsService.new(nil)
    service.run!
    render json: service.results, serializer: Common::PermissionsSerializer, status: :ok
  end

  def show
    request_params = Common::PermissionIdRequestParams.new(params)
    request_params.validate!
    service = Common::ShowPermissionService.new(request_params, nil)
    service.run!
    render json: service.result, each_serializer: Common::ShowPermissionSerializer, status: :ok
  end

  def create
    request_params = Common::UpsertPermissionRequestParams.new(params)
    request_params.validate!
    service = Common::UpsertPermissionService.new(request_params, nil)
    service.run!
    render json: service.result, each_serializer: Common::UpsertPermissionSerializer, status: :ok
  end

  def destroy
    request_params = Common::PermissionIdRequestParams.new(params)
    request_params.validate!
    service = Common::DeletePermissionService.new(request_params, nil)
    service.run!
    render json: { message: service.result }, status: :ok
  end
end
