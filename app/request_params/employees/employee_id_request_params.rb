# frozen_string_literal: true

module Employees
  class EmployeeIdRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer

    validates :id, presence: true

    def initialize(params)
      super(
        id: params[:id]
      )
    end
  end
end
