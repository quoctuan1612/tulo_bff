# frozen_string_literal: true

module Common
  class RoleIdRequestParams < TuloCommon::RequestParamsBase
    attribute :role_id, :string

    validates :role_id, presence: true

    def initialize(params)
      super(
        role_id: params[:id]
      )
    end
  end
end
