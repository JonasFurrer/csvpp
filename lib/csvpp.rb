require 'oj'

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

  # @param input [String] input string
  # @param format [String] format string
  # @param col_sep [String]
  #
  # @return [Array<Object>]
  def self.parse_str(input:, format:, col_sep: DEFAULT_COL_SEP, &block)
    Parser.parse_str(
      input: input,
      format: Format.load_from_str(format),
      col_sep: col_sep,
      &block
    )
  end

  # @param input [String] input string
  # @param format [String] format string
  # @param col_sep [String]
  #
  # @return [String]
  def self.json(input:, format:, col_sep: DEFAULT_COL_SEP)
    h = { 'vars' => parse_str(input: input, format: format, col_sep: col_sep) }
    Oj.dump(h)
  end
end
