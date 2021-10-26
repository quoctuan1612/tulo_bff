# frozen_string_literal: true

module Tasks
  class UpsertTaskService < Tasks::ServiceBase
    attr_reader :result

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      upsert_task_request = Tulo::Tasks::V1::UpsertTaskRequest.new(
        task: Tulo::Tasks::V1::Task.new(
          id: proto_int64(@request_params.id),
          document_incoming_id: proto_int64(@request_params.document_incoming_id),
          department_id: proto_int64(@request_params.department_id),
          employee_id: proto_int64(@request_params.employee_id),
          start_date: proto_string(@request_params.start_date),
          end_date: proto_string(@request_params.end_date),
        )
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.tasks.host,
        Tulo::Tasks::V1::TaskService,
        :UpsertTask,
        upsert_task_request.to_h
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
