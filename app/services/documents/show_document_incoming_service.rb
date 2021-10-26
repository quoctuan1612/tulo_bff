# frozen_string_literal: true

module Documents
  class ShowDocumentIncomingService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Documents::V1::DocumentIncomingIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentIncomingService,
        :GetDocumentIncomingById,
        request_message.to_h
      ).message

      set_result(response.document_incoming)
    end

    def set_result(document_incoming)
      @result = Documents::DocumentIncomingModel.new(
        id: document_incoming.id&.value,
        document_name: document_incoming.document_name&.value,
        document_type_id: document_incoming.document_type_id&.value,
        document_destination_id: document_incoming.document_destination_id&.value,
        abstract: document_incoming.abstract&.value,
        file_path: document_incoming.file_path&.value,
        file_name: document_incoming.file_name&.value,
        created_at: document_incoming.created_at&.value,
        updated_at: document_incoming.updated_at&.value
      )
    end
  end
end
