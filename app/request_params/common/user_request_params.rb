# frozen_string_literal: true

module Common
  class UserRequestParams < TuloCommon::RequestParamsBase
    PASSWORD_FORMAT = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x

    attribute :id, :integer
    attribute :employee_id, :integer
    attribute :user_name, :string
    attribute :password, :string

    validates :employee_id, numericality: { only_integer: true, greater_than: 0 }
    validates :user_name, presence: true
    validates :password, presence: true,
                         length: { within: 8..40 },
                         format: { with: PASSWORD_FORMAT }

    def initialize(params)
      super(
        id: params[:id],
        employee_id: params[:employee_id],
        user_name: params[:user_name],
        password: params[:password]
      )
    end
  end
end
