# frozen_string_literal: true

class Common::V1::UsersController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  
  def index
    service = Common::GetUsersService.new(nil)
    service.run!
    render json: service.results, serializer: Common::UsersSerializer, status: :ok
  end

  def create
    request_params = Common::UserRequestParams.new(params)
    request_params.validate!
    service = Common::UpsertUserService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Common::UserSerializer, status: :ok
  end

  def show
    request_params = Common::UserIdRequestParams.new(params)
    request_params.validate!
    service = Common::ShowUserService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Common::UserSerializer, status: :ok
  end

  def destroy
    request_params = Common::UserIdRequestParams.new(params)
    request_params.validate!
    service = Common::DeleteUserService.new(request_params, nil)
    service.run!
    render json: { message: service.result }, status: :ok
  end

  def login
    request_params = Common::UserLoginRequestParams.new(params)
    request_params.validate!
    service = Common::UserLoginService.new(request_params, nil)
    service.run!
    render json: service.result, status: :ok
  end
end
