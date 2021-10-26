# frozen_string_literal: true

module Documents
  class GetDocumentProcessingTimesService < Documents::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentProcessingTimeService,
        :GetDocumentProcessingTimes
      ).message

      set_results(response.document_processing_times)
    end

    def set_results(document_processing_times)
      @results = Documents::DocumentProcessingTimesModel.new(
        document_processing_times: document_processing_times.each_with_object([]) do |document_processing_time, arr|
          arr << Documents::DocumentProcessingTimeModel.new(
            id: document_processing_time.id&.value,
            document_type_id: document_processing_time.document_type_id&.value,
            document_destination_id: document_processing_time.document_destination_id&.value,
            processing_time: document_processing_time.processing_time&.value,
            created_at: document_processing_time.created_at&.value,
            updated_at: document_processing_time.updated_at&.value
          )
        end
      )
    end
  end
end
