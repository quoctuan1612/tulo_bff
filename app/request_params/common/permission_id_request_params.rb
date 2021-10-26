# frozen_string_literal: true

module Common
  class PermissionIdRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer

    validates :id, presence: true, numericality: { only_integer: true, greater_than: 0 }

    def initialize(params)
      super(
        id: params[:id]
      )
    end
  end
end
