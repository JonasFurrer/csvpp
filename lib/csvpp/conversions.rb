module CSVPP
  module Conversions
    module_function

    def parse_string(str)
      str.to_str
    end

    def parse_int(str)
      str.to_str.to_i
    end
  end
end
