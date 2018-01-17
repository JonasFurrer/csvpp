module CSVPP
  class Format
    attr_reader :name, :skip

    class << self
      # @param name [String] unique name of the format
      # @param format [Format]
      def add(name, format)
        store[name] = format
      end

      # @param name [String] unique name of the format
      def find(name)
        store.fetch(name)
      end

      # @param path [String] path to format file
      # @return [Format]
      def load(path)
        load_from_str File.read(path)
      end

      # @param json [String]
      # @return [Format]
      def load_from_str(json)
        new Oj.load(json)
      end

      def all
        store.values
      end

      def store
        @store ||= {}
      end
    end

    # @param format [Hash]
    def initialize(format)
      @name = format['name']
      @multiline = format['multiline'].to_s.strip.downcase == 'true'
      @skip = format['skip'].to_i
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

    # @param var [String]: name of the variable for which the missings are required
    # @return [Array] an array of missing values (can be empty if no missings were defined)
    def missings(var)
      m = vars.fetch(var)['missings']
      return [] if m.nil?
      return m  if m.is_a?(Array)
      [m]
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
