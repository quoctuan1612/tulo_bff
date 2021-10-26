# frozen_string_literal: true

module Tasks
  class ShowTaskService < Common::ServiceBase
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
        :GetTaskById,
        request_message.to_h
      ).message

      set_result(response.task)
    end

    def set_result(task)
      @result = Tasks::TaskModel.new(
        id: task.id&.value,
        document_incoming_id: task.document_incoming_id&.value,
        department_id: task.department_id&.value,
        employee_id: task.employee_id&.value,
        start_date: task.start_date&.value,
        end_date: task.end_date&.value,
        is_approved_by_staff: task.is_approved_by_staff&.value,
        is_approved_by_leader: task.is_approved_by_leader&.value,
        is_approved_by_manger: task.is_approved_by_manger&.value,
        created_at: task.created_at&.value,
        updated_at: task.updated_at&.value,
      )
    end
  end
end
