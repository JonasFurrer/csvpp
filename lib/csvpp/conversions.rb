require 'bigdecimal'

module CSVPP
  module Conversions
    module_function

    # @param obj [Object]
    # @param to [String] a type, e.g. "int"
    def convert(obj, to:)
      send("parse_#{to}", obj)
    end

    def parse_string(str)
      str.to_s
    end

    def parse_int(str)
      str.to_s.to_i
    end

    def parse_float(str)
      str.to_s.to_f
    end

    def parse_decimal(str)
      BigDecimal(str.to_s)
    end
  end
end
