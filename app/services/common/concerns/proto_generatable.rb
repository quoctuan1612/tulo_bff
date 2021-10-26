# frozen_string_literal: true

module Common
  module Concerns
    module ProtoGeneratable
      extend ActiveSupport::Concern

      private

      def proto_string(value)
        value.blank? ? nil : Google::Protobuf::StringValue.new(value: value.to_s)
      end

      def proto_string_safe(value, default_value)
        Google::Protobuf::StringValue.new(value: value.blank? ? default_value : value.to_s)
      end

      def proto_int32(value)
        value.blank? ? nil : Google::Protobuf::Int32Value.new(value: value.to_i)
      end

      def proto_int64(value)
        value.blank? ? nil : Google::Protobuf::Int64Value.new(value: value.to_i)
      end

      def proto_bool(value)
        value.nil? ? nil : Google::Protobuf::BoolValue.new(value: to_bool(value))
      end

      def proto_bool_safe(value, default_value)
        value.nil? ? Google::Protobuf::BoolValue.new(value: default_value) : Google::Protobuf::BoolValue.new(value: to_bool(value))
      end

      def proto_double(value)
        value.blank? ? nil : Google::Protobuf::DoubleValue.new(value: value.to_f)
      end

      def proto_int64_array(params)
        return [] if params.blank?

        params.compact.uniq.map { |param| proto_int64(param) }
      end

      def proto_string_array(params)
        return [] if params.blank?

        params.reject(&:blank?).uniq.map { |param| proto_string(param) }
      end

      def proto_obj_array_id(params)
        result = params.compact.uniq.map { |param| proto_int64(param[:id]) }
        result.compact
      end

      def proto_key_value_define(value)
        return nil if value.blank?

        Gyro::Crm::V1::Common::KeyValueDefine.new(
          id: proto_int64(value[:id]),
          name: proto_string(value[:name])
        )
      end

      def to_bool(str)
        return str if str.is_a?(FalseClass) || str.is_a?(TrueClass)
        return if !str.is_a?(String) || %w[TRUE True true FALSE False false].exclude?(str)

        %w[TRUE True true].include?(str)
      end
    end
  end
end
