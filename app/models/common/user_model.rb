# frozen_string_literal: true

module Common
  class UserModel < ActiveModelSerializers::Model
    attributes :id,
               :employee_id,
               :user_name,
               :encrypted_password,
               :created_at,
               :updated_at
  end
end
