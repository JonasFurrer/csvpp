module CSVPP
  class Format

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
      @vars = format.fetch('vars')
    end

    def var_names
      vars.keys
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

    private

    attr_reader :vars
  end
end
