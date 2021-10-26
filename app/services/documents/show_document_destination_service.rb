# frozen_string_literal: true

module Documents
  class ShowDocumentDestinationService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Documents::V1::DocumentDestinationIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentDestinationService,
        :GetDocumentDestinationById,
        request_message.to_h
      ).message

      set_result(response.document_destination)
    end

    def set_result(document_destination)
      @result = Documents::DocumentDestinationModel.new(
        id: document_destination.id&.value,
        document_destination_name: document_destination.document_destination_name&.value,
        email: document_destination.email&.value,
        phone: document_destination.phone&.value,
        description: document_destination.description&.value,
        created_at: document_destination.created_at&.value,
        updated_at: document_destination.updated_at&.value
      )
    end
  end
end
