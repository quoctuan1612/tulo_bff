# frozen_string_literal: true

module ErrorRelated
  class FieldErrorSerializer < ActiveModel::Serializer
    attributes :field_name, :field_messages
  end
end
