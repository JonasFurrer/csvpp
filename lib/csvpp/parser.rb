module CSVPP
  class Parser
    include Conversions

    attr_reader :format, :col_sep

    def self.parse(input:, format:, col_sep: DEFAULT_COL_SEP, &block)
      new(format: format, col_sep: col_sep).parse(input, &block)
    end

    def initialize(format:, col_sep: DEFAULT_COL_SEP)
      @format = format
      @col_sep = col_sep
    end

    def parse(path, &block)
      results = []

      File.open(path).each_line do |line|
        columns = line.split(col_sep)

        hash = {}
        format.vars.each do |var|
          index = format.index(var)
          type = format.type(var)
          value = columns[index].strip

          hash[var] = type ? send("parse_#{type}", value) : value
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
