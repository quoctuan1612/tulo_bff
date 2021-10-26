# frozen_string_literal: true

module Documents
  class ShowDocumentProcessingTimeService < Common::ServiceBase
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
        :GetDocumentProcessingTimeById,
        request_message.to_h
      ).message

      set_result(response.document_processing_time)
    end

    def set_result(document_processing_time)
      @result = Documents::DocumentProcessingTimeModel.new(
        id: document_processing_time.id&.value,
        document_type_id: document_processing_time.document_type_id&.value,
        document_destination_id: document_processing_time.document_destination_id&.value,
        processing_time: document_processing_time.processing_time&.value,
        created_at: document_processing_time.created_at&.value,
        updated_at: document_processing_time.updated_at&.value
      )
    end
  end
end
