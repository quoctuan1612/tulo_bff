# frozen_string_literal: true

module InsideError
  class ExceptionHandler < ErrorHandlerBase
    def model
      ErrorRelated::ErrorResponse.new(messages: [@exception.message], field_errors: [])
    end
  end
end
