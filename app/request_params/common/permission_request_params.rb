# frozen_string_literal: true

module Common
  class PermissionRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :role_id, :string
    attribute :description, :string

    validates :role_id, presence: true

    def initialize(permission)
      super(
        id: permission[:id],
        role_id: permission[:role_id],
        description: permission[:description]
      )
    end
  end
end
