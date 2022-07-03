# frozen_string_literal: true

require 'ostruct'

module Outsmart
  attr_reader :data

  class Object < OpenStruct
    def initialize(attributes)
      @data = attributes
      super to_ostruct(attributes)
    end

    def to_ostruct(obj)
      case obj
      when Hash
        OpenStruct.new(obj.transform_values { |val| to_ostruct(val) })
      when Array
        obj.map { |o| to_ostruct(o) }
      else # Assumed to be a primitive value
        obj
      end
    end

    def data
      @attributes
    end
  end
end
