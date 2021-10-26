# frozen_string_literal: true

module ErrorRelated
  class ErrorResponse < ActiveModelSerializers::Model
    attributes :messages, :field_errors
  end
end
