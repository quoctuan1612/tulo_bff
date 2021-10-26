# frozen_string_literal: true

class Tasks::V1::TasksController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler

  def index
    service = Tasks::GetTasksService.new(nil)
    service.run!
    render json: service.results, serializer: Tasks::TasksSerializer, status: :ok
  end

  def create
    request_params = Tasks::UpsertTaskRequestParams.new(params)
    request_params.validate!
    service = Tasks::UpsertTaskService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Tasks::TaskSerializer, status: :ok
  end

  def show
    request_params = Tasks::TaskIdRequestParams.new(params)
    request_params.validate!
    service = Tasks::ShowTaskService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Tasks::TaskSerializer, status: :ok
  end

  def destroy
    request_params = Tasks::TaskIdRequestParams.new(params)
    request_params.validate!
    service = Tasks::DeleteTaskService.new(request_params, nil)
    service.run!
    render json: { message: service.result }, status: :ok
  end
end
