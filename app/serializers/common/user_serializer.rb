# frozen_string_literal: true

module Common
  class UserSerializer < ActiveModel::Serializer
    attributes :id,
               :employee_id,
               :user_name,
               :encrypted_password,
               :created_at,
               :updated_at
    delegate :id,
             :employee_id,
             :user_name,
             :encrypted_password,
             :created_at,
             :updated_at, to: :object
  end
end
