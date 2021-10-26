# frozen_string_literal: true

module Tasks
  class TaskModel < ActiveModelSerializers::Model
    attributes :id,
               :document_incoming_id,
               :department_id,
               :employee_id,
               :start_date,
               :end_date,
               :is_approved_by_staff,
               :is_approved_by_leader,
               :is_approved_by_manger,
               :created_at,
               :updated_at
  end
end