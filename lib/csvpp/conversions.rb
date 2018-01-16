require 'bigdecimal'

module CSVPP
  module Conversions
    module_function

    # @param obj [Object]
    # @param to [String] a type, e.g. "int"
    def convert(obj, to:, na: nil)
      if obj == na.to_s  # obj is always a string, but na isn't necessarily
        send("#{to}_na")
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

    def string_na
      ''
    end

    def date_na
      ''
    end

    def int_na
      nil # urghh
    end

    def float_na
      Float::NAN
    end

    def decimal_na
      BigDecimal::NAN
    end
  end
end
