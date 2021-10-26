# frozen_string_literal: true

module Common
  class UserLoginRequestParams < TuloCommon::RequestParamsBase
    PASSWORD_FORMAT = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x

    attribute :user_info, :string
    attribute :password, :string

    validates :user_info, presence: true

    def initialize(params)
      super(
        user_info: params[:user_info],
        password: params[:password]
      )
    end
  end
end
