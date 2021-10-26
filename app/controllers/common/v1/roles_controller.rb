# frozen_string_literal: true

class Common::V1::RolesController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  
  def index
    service = Common::GetRolesService.new(nil)
    service.run!
    render json: service.results, serializer: Common::RolesSerializer, status: :ok
  end

  def show
    request_params = Common::RoleIdRequestParams.new(params)
    request_params.validate!
    service = Common::ShowRoleService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Common::RoleSerializer, status: :ok
  end

  def create
    request_params = Common::RoleRequestParams.new(params)
    request_params.validate!
    service = Common::UpsertRoleService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Common::RoleSerializer, status: :ok
  end

  def destroy
    request_params = Common::RoleIdRequestParams.new(params)
    request_params.validate!
    service = Common::DeleteRoleService.new(request_params, nil)
    service.run!
    render json: { message: service.result }, status: :ok
  end
end
