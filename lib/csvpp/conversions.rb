require 'bigdecimal'

module CSVPP
  module Conversions
    module_function

    # @param obj [Object] object to parse
    # @param to [String] a type, e.g. "int"
    # @missings [Array] list of values that are treated as missings, e.g. ['NA', '-', -999]
    # @params options [Hash] options passed on to parsing methods for specific types
    # @return parsed value, read from `obj`, interpreted as type given by `to`
    def convert(obj, to:, missings: [], **options)
      return nil if missing?(obj, missings)

      send("parse_#{to}", obj, **options)
    end

    def parse_string(str, **options)
      str.to_s
    end

    def parse_int(str, **options)
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

    def parse_float(str, **options)
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

    def parse_date(str, **options)
      Date.parse(str.to_s)
    end

    # @param true_values [Array]: list of values that are interpreted as `true`
    # @param false_values [Array]: list of values that are interpreted as `false`
    # @return true or false, or
    #      nil if `str` doesn't match any value interpreted as `true` or `false`
    def parse_boolean(str, true_values: [], false_values: [])
      cleaned = str.to_s.strip.downcase

      trues = if true_values.empty?
                ['1', 't', 'true']
              else
                true_values.map(&:to_s).map(&:downcase)
              end
      return true if trues.include? cleaned

      falses = if false_values.empty?
                 ['0', 'f', 'false']
               else
                 false_values.map(&:to_s).map(&:downcase)
               end
      return false if falses.include? cleaned

      nil
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
