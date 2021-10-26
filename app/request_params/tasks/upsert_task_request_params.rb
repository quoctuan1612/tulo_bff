# frozen_string_literal: true

module Tasks
  class UpsertTaskRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :document_incoming_id, :integer
    attribute :department_id, :integer
    attribute :employee_id, :integer
    attribute :start_date, :string
    attribute :end_date, :string
    attribute :is_complete, :boolean


    validates :document_incoming_id,
              :department_id, 
              :employee_id,
              :start_date, presence: true


    def initialize(task)
      super(
        id: task[:id],
        document_incoming_id: task[:document_incoming_id],
        department_id: task[:department_id],
        employee_id: task[:employee_id],
        start_date: task[:start_date],
        end_date: task[:end_date],
      )
    end
  end
end
