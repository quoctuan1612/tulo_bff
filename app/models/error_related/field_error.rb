# frozen_string_literal: true

module ErrorRelated
  class FieldError < ActiveModelSerializers::Model
    attributes :field_name, :field_messages
  end
end
