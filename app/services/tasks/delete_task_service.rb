# frozen_string_literal: true

module Tasks
  class DeleteTaskService < Documents::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Tasks::V1::TaskIdRequest.new(
        id: proto_int64(@request_params.id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.tasks.host,
        Tulo::Tasks::V1::TaskService,
        :DeleteTaskById,
        request_message.to_h
      ).message

      @result = response.message&.value
    end
  end
end
