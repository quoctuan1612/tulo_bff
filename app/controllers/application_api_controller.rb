# frozen_string_literal: true

class ApplicationApiController < ApplicationController
  include TuloCommon::RequestHandler::AuthRestHeaderHandler
  include TuloCommon::RequestHandler::JwtHandler

  rescue_from StandardError, with: :render_exception

  def render_exception(exception)
    handler = InsideErrorHandlerMapper.get_handler(exception)
    return render handler.to_response if handler&.handled?

    status_code = Rack::Utils.status_code(
      ActionDispatch::ExceptionWrapper.rescue_responses[exception.class.to_s] || :internal_server_error
    )
    render InsideError::ExceptionHandler.new(exception, status_code).to_response
    raise exception if status_code >= 500
  end
end
