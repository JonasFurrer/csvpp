module CSVPP
  class Format
    attr_reader :format

    def self.load(path)
      load_from_str File.read(path)
    end

    def self.load_from_str(json)
      new JSON.parse(json)
    end

    # @param format [Hash]
    def initialize(format)
      @format = format
    end

    def vars
      format.keys
    end

    def index(var)
      format.fetch(var)['index']
    end

    def type(var)
      format.fetch(var)['type']
    end
  end
end
