# frozen_string_literal: true

module Common
  class GetWardsByDistrictIdService < Common::ServiceBase
    attr_reader :results

    def initialize(request_params, auth_header)
      @request_params = request_params
      @auth_header = auth_header
    end

    def run!
      request_message = Tulo::Common::V1::DistrictIdRequest.new(
        district_id: proto_int64(@request_params.district_id)
      )

      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::MasterService,
        :GetWardsByDistrictId,
        request_message.to_h
      ).message

      set_results(response.wards)
    end

    def set_results(wards)
      @results = {
        master_wards: wards&.each_with_object([]) do |ward, arr|
          arr << Common::WardModel.new(
            id: ward.id&.value,
            name: ward.name&.value,
            code: ward.code&.value,
            code_name: ward.code_name&.value,
            division_type: ward.division_type&.value,
            short_code_name: ward.short_code_name&.value,
            master_district_id: ward.master_district_id&.value
          )
        end
      }
    end
  end
end
