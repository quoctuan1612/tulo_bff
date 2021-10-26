# frozen_string_literal: true

module Common
  class ServiceBase
    include Common::Concerns::ProtoGeneratable

    def initialize
      raise NotImplementedError
    end

    def run!
      raise NotImplementedError
    end

    def filter_proto(type, value)
      return if value.nil?

      case type
      when :int32
        Google::Protobuf::Int32Value.new(value: value)
      when :int64
        Google::Protobuf::Int64Value.new(value: value)
      when :string
        Google::Protobuf::StringValue.new(value: value)
      when :boolean
        Google::Protobuf::BoolValue.new(value: value)
      end
    end
  end
end
