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
      return nil if str.to_s.empty?

      cleaned = if str.is_a?(String)
                  val = str.strip
                          .gsub(/['`\s]?/, '')      # remove thousand separators
                          .sub(/\.\d*/, '')         # remove decimal point and everything thereafter
                          .sub(/[\sa-zA-Z]*$/, '')  # remove trailing words like "mg"
                          .sub(/^-0*(.+)$/, '-\1')  # remove 0 after negative sign: -003 => -3
                  val =~ /^0+$/ ? '0' : val.gsub( /^0*/, '')      # remove leading zeros
                else
                  str
                end
      Integer(cleaned) rescue nil
    end

    def parse_float(str)
      return nil if str.to_s.empty?
      Float(clean_decimal(str)) rescue nil
    end

    def parse_decimal(str)
      return nil if str.to_s.empty?

      cleaned = clean_decimal(str).to_s

      if cleaned.empty?
        nil
      else
        BigDecimal(cleaned)
      end

    end

    def parse_date(str)
      Date.parse(str.to_s)
    end

    def missing?(obj, missings)
      missings.map(&:to_s).include?(obj.to_s)
    end

    def clean_decimal(str)
      return str unless str.is_a?(String)

      val = str.strip
               .gsub(/['`\s]?/, '')               # remove thousand separators
               .sub(/[\sa-zA-Z]*$/, '')           # remove trailing words like "mg"
               .sub(/^-0*(.+)$/, '-\1')           # remove 0 after negative sign: -003 => -3
      if val =~ /^0+$/                            # remove leading zeros
        '0'
      else
        val.gsub( /^0*/, '')
      end
    end
  end
end
