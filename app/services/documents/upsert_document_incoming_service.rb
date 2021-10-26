# frozen_string_literal: true

module Documents
  class UpsertDocumentIncomingService < Documents::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      upsert_document_incoming_request = Tulo::Documents::V1::UpsertDocumentIncomingRequest.new(
        document_incoming: Tulo::Documents::V1::DocumentIncoming.new(
          id: proto_int64(@request_params.id),
          document_name: proto_string(@request_params.document_name),
          document_type_id: proto_int64(@request_params.document_type_id),
          document_destination_id: proto_int64(@request_params.document_destination_id),
          abstract: proto_string(@request_params.abstract),
          file_path: proto_string(@request_params.file_path),
          file_name: proto_string(@request_params.file_name)
        )
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.documents.host,
        Tulo::Documents::V1::DocumentIncomingService,
        :UpsertDocumentIncoming,
        upsert_document_incoming_request.to_h
      ).message

      set_result(response.document_incoming)
    end

    private

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

      if @result.file_path.present?
        save_file(@result)
      else
        file_exsit?(@result.id)
      end
    end

    def save_file(document_incoming)
      dir_path = File.join('public', 'uploads', 'documents_incoming', document_incoming.id.to_s)
      file_exsit?(@request_params.id) if @request_params&.id.present?
      FileUtils.mkdir_p dir_path unless File.exist?(dir_path)
      FileUtils.move @request_params.tmp, File.join(dir_path, document_incoming.file_name)
      FileUtils.chmod_R 0_777, dir_path
    end

    def file_exsit?(id)
      dir_path = Rails.root.join('public', 'uploads', 'documents_incoming', id.to_s)
      file_path = Dir.glob("#{dir_path}/*").first
      File.delete file_path if File.exist?(file_path.to_s)
    end
  end
end
