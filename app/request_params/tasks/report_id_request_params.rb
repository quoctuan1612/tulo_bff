# frozen_string_literal: true

module Tasks
  class ReportIdRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer

    validates :id, numericality: { only_integer: true, greater_than: 0 }

    def initialize(params)
      super(
        id: params[:id]
      )
    end
  end
end
