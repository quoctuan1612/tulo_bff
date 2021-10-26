# frozen_string_literal: true

module Employees
  class UpsertEmployeeRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :first_name, :string
    attribute :last_name, :string
    attribute :gender, :string
    attribute :dob, :string
    attribute :email, :string
    attribute :phone, :string
    attribute :master_country_id, :integer
    attribute :master_province_id, :integer
    attribute :master_district_id, :integer
    attribute :master_ward_id, :integer
    attribute :owner_id, :integer
    attribute :department_id, :integer
    attribute :role_id, :string

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :gender, presence: true

    def initialize(employee)
      super(
        id: employee[:id],
        first_name: employee[:first_name],
        last_name: employee[:last_name],
        gender: employee[:gender],
        dob: employee[:dob],
        email: employee[:email],
        phone: employee[:phone],
        master_country_id: employee[:master_country_id],
        master_province_id: employee[:master_province_id],
        master_district_id: employee[:master_district_id],
        master_ward_id: employee[:master_ward_id],
        owner_id: employee[:owner_id],
        department_id: employee[:department_id],
        role_id: employee[:role_id]
      )
    end
  end
end
