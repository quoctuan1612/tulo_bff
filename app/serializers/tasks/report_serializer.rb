# frozen_string_literal: true

module Tasks
  class ReportSerializer < ActiveModel::Serializer
    attributes :id,
               :document_incoming_id,
               :employee_id,
               :role_name,
               :message,
               :created_at,
               :updated_at
    delegate :id,
             :document_incoming_id,
             :employee_id,
             :role_name,
             :message,
             :created_at,
             :updated_at, to: :object
  end
end
