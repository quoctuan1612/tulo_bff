# frozen_string_literal: true

module Common
  class CountryModel < ActiveModelSerializers::Model
    attributes :id,
               :name,
               :code,
               :code_name,
               :phone_code
  end
end
