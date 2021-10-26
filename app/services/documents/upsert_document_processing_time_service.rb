# frozen_string_literal: true

module Documents
  class UpsertDocumentProcessingTimeService < Documents::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      upsert_document_processing_time_request = Tulo::Documents::V1::UpsertDocumentProcessingTimeRequest.new(
        document_processing_time: Tulo::Documents::V1::DocumentProcessingTime.new(
          id: proto_int64(@request_params.id),
          document_type_id: proto_int64(@request_params.document_type_id),
          document_destination_id: proto_int64(@request_params.document_destination_id),
          processing_time: proto_int32(@request_params.processing_time)
        )
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentProcessingTimeService,
        :UpsertDocumentProcessingTime,
        upsert_document_processing_time_request.to_h
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
