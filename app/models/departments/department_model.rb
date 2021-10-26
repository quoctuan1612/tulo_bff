# frozen_string_literal: true

module Departments
  class DepartmentModel < ActiveModelSerializers::Model
    attributes :id,
               :department_name,
               :parent_department_id,
               :mgr_id,
               :description,
               :created_at,
               :updated_at
  end
end
