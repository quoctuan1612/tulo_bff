# frozen_string_literal: true

module Documents
  class DeleteDocumentIncomingService < Documents::ServiceBase
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
        :DeleteDocumentIncomingById,
        request_message.to_h
      ).message

      delete_file
      @result = response.message&.value
    end

    private

    def delete_file
      file_path = Rails.root.join('public', 'uploads', 'documents_incoming', @request_params.id.to_s)
      FileUtils.rm_rf file_path if File.exist?(file_path)
    end
  end
end
