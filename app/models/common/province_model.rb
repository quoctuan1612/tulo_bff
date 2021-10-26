# frozen_string_literal: true

module Common
  class ProvinceModel < ActiveModelSerializers::Model
    attributes :id,
               :name,
               :code,
               :code_name,
               :division_type,
               :phone_code,
               :master_country_id
  end
end
