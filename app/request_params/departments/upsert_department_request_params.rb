# frozen_string_literal: true

module Departments
  class UpsertDepartmentRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :department_name, :string
    attribute :parent_department_id, :integer
    attribute :mgr_id, :integer
    attribute :description, :string

    validates :department_name, presence: true
    validates :parent_department_id, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
    validates :mgr_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

    def initialize(department)
      super(
        id: department[:id],
        department_name: department[:department_name],
        parent_department_id: department[:parent_department_id],
        mgr_id: department[:mgr_id],
        description: department[:description]
      )
    end
  end
end
