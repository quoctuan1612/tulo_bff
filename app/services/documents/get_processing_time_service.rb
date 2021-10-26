# frozen_string_literal: true

module Documents
  class GetProcessingTimeService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Documents::V1::RequestParams.new(
        document_type_id: proto_int64(@request_params.document_type_id),
        document_destination_id: proto_int64(@request_params.document_destination_id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentProcessingTimeService,
        :GetProcessingTime,
        request_message.to_h
      ).message

      @result = response
    end
  end
end
