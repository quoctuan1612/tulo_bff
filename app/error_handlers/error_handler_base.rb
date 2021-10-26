# frozen_string_literal: true

class ErrorHandlerBase
  attr_reader :exception, :status

  def initialize(exception, status = nil)
    @exception = exception
    @status = status
  end

  def to_response
    {
      json: error_body,
      status: error_status
    }
  end

  def handled?
    true
  end

  def model
    raise NotImplementedError
  end

  def error_body
    serializer = ErrorRelated::ErrorResponseSerializer.new(model)
    serializer.to_json
  end

  def error_status
    return @status if @status

    raise NotImplementedError
  end
end
