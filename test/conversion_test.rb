require "test_helper"

class ConversionTest < Minitest::Test

  class FakeParser
    include CSVPP::Conversions

    public :convert, :parse_string, :parse_int, :parse_float, :parse_decimal, :parse_date
  end


  def setup
    @parser = FakeParser.new
  end

  def test_convert
    assert_equal 30000, @parser.convert("030'000.32 mg", to: 'int')
    assert_equal'snow', @parser.convert('snow', to: 'string', missings: ['rain'])
  end

  def test_convert_missing
    assert_nil @parser.convert('-', to: 'float', missings: ['NA', '-'])
  end

  def test_parse_int
    test_data = [
      # [input, expected]
      ['3', 3],
      [3, 3],
      ['3.4', 3],
      ["0010'000.4", 10000],
      ["20`000", 20000],
      ["30 000", 30000],
      ['040kg', 40],
      ["-00050'000.40 mg", -50000],
      [0, 0],
      ['0', 0],
      ['', nil],
      [nil, nil],
      ['NA', nil]
    ]
    assert_pairs_match(test_data){ |input| @parser.parse_int(input) }
  end

  def test_parse_string
    test_data = [
      #[input, expected]
      ['Schokolade', 'Schokolade'],
      ['', ''],
      [nil, '']
    ]
    assert_pairs_match(test_data){ |input| @parser.parse_string(input) }
  end

  def test_parse_float
    test_data = [
      #[input, expected]
      [3.3, 3.3],
      ['4.4', 4.4],
      ['05.50', 5.5],
      ['006 000.06', 6000.06],
      ['-0700.123456789 kg', -700.123456789],
      ['-.0320', -0.032],
      ['', nil],
      [nil, nil],
      ['NA', nil]
    ]
    assert_pairs_match(test_data){ |input| @parser.parse_float(input) }
  end

  def test_parse_decimal
    test_data = [
      #[input, expected]
      [3.3, 3.3],
      ['4.4', 4.4],
      ['05.50', 5.5],
      ['006 000.6', 6000.6],
      ['-0700.123456789 kg', -700.123456789],
      ['0.80000000000000000555111512312578270211815834045',
       BigDecimal('0.80000000000000000555111512312578270211815834045')],
      [BigDecimal('0.90000000000000000555111512312578270211815834045'),
       BigDecimal('0.90000000000000000555111512312578270211815834045')],
      ['', nil],
      [nil, nil],
      ['NA', nil]
    ]
    assert_pairs_match(test_data){ |input| @parser.parse_decimal(input) }
  end
end
