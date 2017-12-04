require 'json'

require 'csvpp/version'
require 'csvpp/conversions'
require 'csvpp/format'
require 'csvpp/parser'

module CSVPP

  DEFAULT_COL_SEP = '|'

  # @param input [String] path to input file
  # @param format [String] path to format file
  # @param col_sep [String]
  #
  # @return [Array<Object>]
  def self.parse(input:, format:, col_sep: DEFAULT_COL_SEP, &block)
    Parser.parse(
      input: input,
      format: Format.load(format),
      col_sep: col_sep,
      &block
    )
  end

  # @param input [String] path to input file
  # @param format [String] path to format file
  # @param col_sep [String]
  #
  # @return [String]
  def self.json(input:, format:, col_sep: DEFAULT_COL_SEP)
    { vars: parse(input: input, format: format, col_sep: col_sep) }.to_json
  end
end
