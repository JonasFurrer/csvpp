require 'bigdecimal'

module CSVPP
  module Conversions
    module_function

    # @param obj [Object]
    # @param to [String] a type, e.g. "int"
    def convert(obj, to:, missings: [])
      if missing?(obj, missings)
        nil
      else
        send("parse_#{to}", obj)
      end
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

    def parse_date(str)
      Date.parse(str.to_s)
    end

    def missing?(obj, missings)
      missings.map(&:to_s).include?(obj.to_s)
    end
  end
end
