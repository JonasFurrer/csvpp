module CSVPP
  class Parser
    include Conversions

    attr_reader :format, :col_sep

    def self.parse(input:,
                   format:,
                   col_sep: DEFAULT_COL_SEP,
                   convert_type: true,
                   &block)

      new(
        format: format,
        col_sep: col_sep,
        convert_type: convert_type,
      ).parse(input, &block)
    end

    def initialize(format:, col_sep: DEFAULT_COL_SEP, convert_type: true)
      @format = format
      @col_sep = col_sep
      @convert_type = convert_type
    end

    def convert_type?
      !!@convert_type
    end

    def parse(path, &block)
      results = []

      File.open(path).each_line.with_index do |line, index|
        line_number = index + 1
        columns = line.split(col_sep)

        hash = {}
        format.var_names.each do |var|
          index = format.index(var)
          value = columns[index].strip
          hash[var] = value
          hash["line_number"] = line_number

          if convert_type?
            type = format.type(var)
            next if type.nil?

            hash[var] = convert(value, to: type)
          end
        end

        if block_given?
          results << block.call(hash)
        else
          results << hash
        end
      end

      results
    end
  end
end
