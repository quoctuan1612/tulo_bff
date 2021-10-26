# frozen_string_literal: true

module Documents
  class GetDocumentsIncomingService < Documents::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentIncomingService,
        :GetDocumentsIncoming
      ).message

      set_results(response.documents_incoming)
    end

    def set_results(documents_incoming)
      @results = Documents::DocumentsIncomingModel.new(
        documents_incoming: documents_incoming.each_with_object([]) do |document_incoming, arr|
          arr << Documents::DocumentIncomingModel.new(
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
      )
    end
  end
end
