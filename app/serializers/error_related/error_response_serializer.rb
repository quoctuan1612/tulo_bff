# frozen_string_literal: true

module ErrorRelated
  class ErrorResponseSerializer < ActiveModel::Serializer
    attributes :messages, :details

    def details
      object.field_errors
    end
  end
end
