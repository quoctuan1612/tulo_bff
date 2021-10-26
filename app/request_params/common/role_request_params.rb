# frozen_string_literal: true

module Common
  class RoleRequestParams < TuloCommon::RequestParamsBase
    attribute :id, :integer
    attribute :role_id, :string
    attribute :role_name, :string
    attribute :description, :string

    validates :id, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
    validate :validate_role_id
    validate :validate_role_name

    def initialize(params)
      super(
        id: params[:id],
        role_id: params[:role_id],
        role_name: params[:role_name],
        description: params[:description]
      )
    end

    private

    def validate_role_id
      errors.add :role_id, I18n.t('errors.messages.role.blank') if role_id.blank?
    end

    def validate_role_name
      errors.add :role_name, I18n.t('errors.messages.role.blank') if role_name.blank?
    end
  end
end
