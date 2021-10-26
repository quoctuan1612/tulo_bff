# frozen_string_literal: true

module Tasks
  class UpsertReportRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :document_incoming_id, :integer
    attribute :employee_id, :integer
    attribute :role_name, :string
    attribute :message, :string


    validates :document_incoming_id,
              :employee_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :role_name,
              :message, presence: true


    def initialize(report)
      super(
        id: report[:id],
        document_incoming_id: report[:document_incoming_id],
        employee_id: report[:employee_id],
        role_name: report[:role_name],
        message: report[:message],
      )
    end
  end
end
