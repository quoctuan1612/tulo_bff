# frozen_string_literal: true

module Documents
  class GetDocumentTypesService < Documents::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentTypeService,
        :GetDocumentTypes
      ).message

      set_results(response.document_types)
    end

    def set_results(document_types)
      @results = Documents::DocumentTypesModel.new(
        document_types: document_types.each_with_object([]) do |document_type, arr|
          arr << Documents::DocumentTypeModel.new(
            id: document_type.id&.value,
            document_type_name: document_type.document_type_name&.value,
            description: document_type.description&.value
          )
        end
      )
    end
  end
end
