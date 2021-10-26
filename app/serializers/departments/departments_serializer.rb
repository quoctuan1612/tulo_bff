# frozen_string_literal: true

module Departments
  class DepartmentsSerializer < ActiveModel::Serializer
    attributes :departments

    delegate to: :object

    def departments
      object.departments.each_with_object([]) do |department, arr|
        arr << Departments::DepartmentSerializer.new(department)
      end
    end
  end
end
