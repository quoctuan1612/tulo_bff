# frozen_string_literal: true

module Tasks
  class ReportModel < ActiveModelSerializers::Model
    attributes :id,
               :document_incoming_id,
               :employee_id,
               :role_name,
               :message,
               :created_at,
               :updated_at
  end
end
