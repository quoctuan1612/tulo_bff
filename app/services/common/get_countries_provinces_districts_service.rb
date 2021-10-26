# frozen_string_literal: true

module Common
  class GetCountriesProvincesDistrictsService < Common::ServiceBase
    attr_reader :results

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def run!
      response = TuloCommon::GrpcService.call_grpc(
        nil,
        Settings.common.host,
        Tulo::Common::V1::MasterService,
        :GetCountriesProvincesDistricts
      ).message

      set_results(response)
    end

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def set_results(response)
      @results = {
        master_countries: response.countries&.each_with_object([]) do |country, arr|
          arr << Common::CountryModel.new(
            id: country.id&.value,
            name: country.name&.value,
            code: country.code&.value,
            code_name: country.code_name&.value,
            phone_code: country.phone_code&.value
          )
        end,
        master_provinces: response.provinces&.each_with_object([]) do |province, arr|
          arr << Common::ProvinceModel.new(
            id: province.id&.value,
            name: province.name&.value,
            code: province.code&.value,
            code_name: province.code_name&.value,
            division_type: province.division_type&.value,
            phone_code: province.phone_code&.value,
            master_country_id: province.master_country_id&.value
          )
        end,
        master_districts: response.districts&.each_with_object([]) do |district, arr|
          arr << Common::DistrictModel.new(
            id: district.id&.value,
            name: district.name&.value,
            code: district.code&.value,
            code_name: district.code_name&.value,
            division_type: district.division_type&.value,
            short_code_name: district.short_code_name&.value,
            master_province_id: district.master_province_id&.value
          )
        end
      }
    end
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/PerceivedComplexity
  end
end
