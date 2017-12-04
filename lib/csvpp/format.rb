module CSVPP
  class Format
    attr_reader :name

    # @param path [String] path to format file
    # @return [Format]
    def self.load(path)
      load_from_str File.read(path)
    end

    # @param json [String]
    # @return [Format]
    def self.load_from_str(json)
      new Oj.load(json)
    end

    # @param format [Hash]
    def initialize(format)
      @name = format['name']
      @multiline = format['multiline'].to_s.strip.downcase == 'true'
      @vars = format.fetch('vars')

      if multiline?
        @vars_grouped_by_line = Hash[
          vars.group_by { |var, meta| meta['line'] }.map do |line_id, vars|
            [line_id, vars.map { |var, *| var }]
          end
        ]

        @multiline_start = format.fetch('start')
      end
    end

    def var_names
      vars.keys
    end

    def length
      var_names.count
    end

    def index(var)
      position(var) - 1
    end

    def position(var)
      vars.fetch(var)['position']
    end

    def type(var)
      vars.fetch(var)['type']
    end

    def vars_for_line(line_id)
      vars_grouped_by_line.fetch(line_id)
    end

    def multiline_start?(line_id)
      multiline_start == line_id
    end

    def multiline?
      @multiline
    end

    private

    attr_reader :vars, :vars_grouped_by_line, :multiline_start
  end
end
