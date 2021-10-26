# frozen_string_literal: true

module Documents
  class DeleteDocumentProcessingTimeService < Documents::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Documents::V1::DocumentProcessingTimeIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentProcessingTimeService,
        :DeleteDocumentProcessingTimeById,
        request_message.to_h
      ).message

      @result = response.message&.value
    end
  end
end
