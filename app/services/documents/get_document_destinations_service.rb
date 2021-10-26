# frozen_string_literal: true

module Documents
  class GetDocumentDestinationsService < Documents::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentDestinationService,
        :GetDocumentDestinations
      ).message

      set_results(response.document_destinations)
    end

    def set_results(document_destinations)
      @results = Documents::DocumentDestinationsModel.new(
        document_destinations: document_destinations.each_with_object([]) do |document_destination, arr|
          arr << Documents::DocumentDestinationModel.new(
            id: document_destination.id&.value,
            document_destination_name: document_destination.document_destination_name&.value,
            email: document_destination.email&.value,
            phone: document_destination.phone&.value,
            description: document_destination.description&.value,
            created_at: document_destination.created_at&.value,
            updated_at: document_destination.updated_at&.value
          )
        end
      )
    end
  end
end
