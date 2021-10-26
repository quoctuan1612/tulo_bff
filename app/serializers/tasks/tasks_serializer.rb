# frozen_string_literal: true

module Tasks
  class TasksSerializer < ActiveModel::Serializer
    attributes :tasks

    delegate to: :object

    def tasks
      object.tasks.each_with_object([]) do |task, arr|
        arr << Tasks::TaskSerializer.new(task)
      end
    end
  end
end
