# frozen_string_literal: true

module Documents
  class ShowDocumentTypeService < Common::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Documents::V1::DocumentTypeIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentTypeService,
        :GetDocumentTypeById,
        request_message.to_h
      ).message

      set_result(response.document_type)
    end

    def set_result(document_type)
      @result = Documents::DocumentTypeModel.new(
        id: document_type.id&.value,
        document_type_name: document_type.document_type_name&.value,
        description: document_type.description&.value
      )
    end
  end
end
