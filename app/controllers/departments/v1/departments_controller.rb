# frozen_string_literal: true

class Departments::V1::DepartmentsController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  
  def index
    service = Departments::GetDepartmentsService.new(nil)
    service.run!
    render json: service.results, serializer: Departments::DepartmentsSerializer, status: :ok
  end

  def create
    request_params = Departments::UpsertDepartmentRequestParams.new(params)
    request_params.validate!
    service = Departments::UpsertDepartmentService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Departments::DepartmentSerializer, status: :ok
  end

  def show
    request_params = Departments::DepartmentIdRequestParams.new(params)
    request_params.validate!
    service = Departments::ShowDepartmentService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Departments::DepartmentSerializer, status: :ok
  end

  def destroy
    request_params = Departments::DepartmentIdRequestParams.new(params)
    request_params.validate!
    service = Departments::DeleteDepartmentService.new(request_params, nil)
    service.run!
    render json: { message: service.result }, status: :ok
  end
end
