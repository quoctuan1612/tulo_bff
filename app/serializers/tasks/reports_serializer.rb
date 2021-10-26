# frozen_string_literal: true

module Tasks
  class ReportsSerializer < ActiveModel::Serializer
    attributes :reports

    delegate to: :object

    def reports
      object.reports.each_with_object([]) do |report, arr|
        arr << Tasks::ReportSerializer.new(report)
      end
    end
  end
end
