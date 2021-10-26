# frozen_string_literal: true

module InsideError
  class GrpcNotFoundErrorHandler < ErrorHandlerBase
    HANDLE_APP_CODE = [
      'custom'
    ].freeze

    def handled?
      HANDLE_APP_CODE.include? @exception.error['app_code']
    end

    def model
      field_errors = @exception.error['field_errors'].to_a
      ErrorRelated::ErrorResponse.new(messages: [@exception.error['message']], field_errors: field_errors)
    end

    def error_status
      404
    end
  end
end
