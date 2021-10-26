# frozen_string_literal: true

module Common
  class WardModel < ActiveModelSerializers::Model
    attributes :id,
               :name,
               :code,
               :code_name,
               :division_type,
               :short_code_name,
               :master_district_id
  end
end
