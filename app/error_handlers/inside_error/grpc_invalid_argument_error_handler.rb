# frozen_string_literal: true

module InsideError
  class GrpcInvalidArgumentErrorHandler < ErrorHandlerBase
    CUSTOM_APP_CODE = 'custom'

    def handled?
      @exception.error['app_code'] == CUSTOM_APP_CODE
    end

    def model
      messages = []
      field_errors_h = @exception.error['field_errors']
      field_errors = field_errors_h.group_by { |field_error| field_error['field_name'] }.map { |name, errors|
        ErrorRelated::FieldError.new(field_name: name, field_messages: errors.map { |error_h|
                                                                         error_h['message']
                                                                       }.flatten)
      }
      ErrorRelated::ErrorResponse.new(messages: messages, field_errors: field_errors)
    end

    def error_status
      422
    end
  end
end
