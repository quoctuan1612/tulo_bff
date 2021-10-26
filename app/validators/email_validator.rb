# frozen_string_literal: true

require 'active_record'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute.to_s, "#{value} #{I18n.t('errors.messages.invalid_address')}") unless /[^\s]@[^\s]/.match?(value)
  end
end
