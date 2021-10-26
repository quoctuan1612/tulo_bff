# frozen_string_literal: true

module InsideError
  class InvalidRequestParamsErrorHandler < ErrorHandlerBase
    def model
      field_errors = @exception.errors.messages.map { |field_name, messages|
        { field_name: field_name, field_messages: messages }
      }
      ErrorRelated::ErrorResponse.new(messages: [], field_errors: field_errors)
    end

    def error_status
      400
    end
  end
end
