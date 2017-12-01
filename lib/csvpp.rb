require "csvpp/version"

require 'json'

require_relative 'csvpp/conversions'
require_relative 'csvpp/format'
require_relative 'csvpp/parser'

module CSVPP

  DEFAULT_COL_SEP = '|'

  # @param input [String] path to input file
  # @param format [String] path to format file
  # @param col_sep [String]
  #
  # @return [Array<Object>]
  def self.parse(input, format:, col_sep: DEFAULT_COL_SEP, &block)
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
  def self.json(input, format:, col_sep: DEFAULT_COL_SEP)
    { vars: parse(input, format: format, col_sep: col_sep) }.to_json
  end
end
