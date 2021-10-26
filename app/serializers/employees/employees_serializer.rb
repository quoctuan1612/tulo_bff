# frozen_string_literal: true

module Employees
  class EmployeesSerializer < ActiveModel::Serializer
    attributes :employees

    delegate to: :object

    def employees
      object.employees.each_with_object([]) do |employee, arr|
        arr << Employees::EmployeeSerializer.new(employee)
      end
    end
  end
end
