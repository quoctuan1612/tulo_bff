# frozen_string_literal: true

module Tasks
  class GetTasksService < Tasks::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.tasks.host,
        Tulo::Tasks::V1::TaskService,
        :GetTasks
      ).message

      set_results(response.tasks)
    end

    def set_results(tasks)
      @results = Tasks::TasksModel.new(
        tasks: tasks.each_with_object([]) do |task, arr|
          arr << Tasks::TaskModel.new(
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
      )
    end
  end
end
