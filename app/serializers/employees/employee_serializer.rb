# frozen_string_literal: true

module Employees
  class EmployeeSerializer < ActiveModel::Serializer
    attributes :id,
               :first_name,
               :last_name,
               :gender,
               :dob,
               :email,
               :phone,
               :master_country_id,
               :master_province_id,
               :master_district_id,
               :master_ward_id,
               :owner_id,
               :department_id,
               :role_id,
               :created_at,
               :updated_at
    delegate :id,
             :first_name,
             :last_name,
             :gender,
             :dob,
             :email,
             :phone,
             :master_country_id,
             :master_province_id,
             :master_district_id,
             :master_ward_id,
             :owner_id,
             :department_id,
             :role_id,
             :created_at,
             :updated_at, to: :object
  end
end
