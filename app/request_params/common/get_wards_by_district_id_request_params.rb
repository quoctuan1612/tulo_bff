# frozen_string_literal: true

module Common
  class GetWardsByDistrictIdRequestParams < TuloCommon::RequestParamsBase
    attribute :district_id, :integer

    validates :district_id, numericality: { only_integer: true, greater_than: 0 }

    def initialize(params)
      super(
        district_id: params[:district_id]
      )
    end
  end
end
