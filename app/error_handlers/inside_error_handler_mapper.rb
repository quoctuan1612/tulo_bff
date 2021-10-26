# frozen_string_literal: true

module InsideErrorHandlerMapper
  HANDLER_MAP = {
    TuloCommon::RequestParamsBase::InvalidRequestParams => InsideError::InvalidRequestParamsErrorHandler,
    Gruf::Client::Errors::InvalidArgument => InsideError::GrpcInvalidArgumentErrorHandler,
    Gruf::Client::Errors::NotFound => InsideError::GrpcNotFoundErrorHandler
  }.freeze

  def self.get_handler(exception)
    HANDLER_MAP[exception.class]&.new(exception)
  end
end
