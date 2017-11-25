module CSVPP
  module Conversions
    module_function

    # @param obj [Object]
    # @param to [String] a type, e.g. "int"
    def convert(obj, to:)
      send("parse_#{to}", obj)
    end

    def parse_string(str)
      str.to_str
    end

    def parse_int(str)
      str.to_str.to_i
    end
  end
end
