# frozen_string_literal: true

class Employees::V1::EmployeesController < ApplicationApiController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  
  def index
    service = Employees::GetEmployeesService.new(nil)
    service.run!
    render json: service.results, serializer: Employees::EmployeesSerializer, status: :ok
  end

  def create
    request_params = Employees::UpsertEmployeeRequestParams.new(params)
    request_params.validate!
    service = Employees::UpsertEmployeeService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Employees::EmployeeSerializer, status: :ok
  end

  def show
    request_params = Employees::EmployeeIdRequestParams.new(params)
    request_params.validate!
    service = Employees::ShowEmployeeService.new(request_params, nil)
    service.run!
    render json: service.result, serializer: Employees::EmployeeSerializer, status: :ok
  end

  def destroy
    request_params = Employees::EmployeeIdRequestParams.new(params)
    request_params.validate!
    service = Employees::DeleteEmployeeService.new(request_params, nil)
    service.run!
    render json: { message: service.result }, status: :ok
  end
end
