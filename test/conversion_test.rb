require "test_helper"
module CSVPP
  class ConversionTest < Minitest::Test
    
    def test_convert
      assert_equal 30000, Conversions.convert("030'000.32 mg", to: 'int')
      assert_equal'snow', Conversions.convert('snow',
                                                   to: 'string',
                                                   missings: ['rain'] )
    end

    def test_convert_missing
      assert_nil Conversions.convert('-',
                                     to: 'float',
                                     missings: ['NA', '-'] )
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
      assert_pairs_match(test_data){ |input| Conversions.parse_int(input) }
    end

    def test_parse_string
      test_data = [
        #[input, expected]
        ['Schokolade', 'Schokolade'],
        ['', ''],
        [nil, '']
      ]
      assert_pairs_match(test_data){ |input| Conversions.parse_string(input) }
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
      assert_pairs_match(test_data){ |input| Conversions.parse_float(input) }
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
      assert_pairs_match(test_data){ |input| Conversions.parse_decimal(input) }
    end

    def test_parse_boolean
      test_data = [
        [true, true],
        [false, false],
        ['true', true],
        ['false', false],
        [1, true],
        ['1', true],
        [0, false],
        ['0', false],
        ['t', true],
        ['f', false],
        [2, nil],
        ['', nil],
        [nil, nil],
        [-1, nil],
        ['-1', nil],
        ['NA', nil],
        ['WAHR!', nil]
      ]
      assert_pairs_match(test_data){ |input| Conversions.parse_boolean(input) }
    end

    def test_parse_boolean_with_true_and_false_values
      assert_equal(true, Conversions.parse_boolean('durchaus', true_values: [true, 'durchaus', 'YES']))
      assert_equal(true, Conversions.parse_boolean(100, true_values: [100, 'durchaus', 'YES']))
      assert_equal(nil, Conversions.parse_boolean(true, true_values: ['durchaus', 'YES']))
      assert_equal(nil, Conversions.parse_boolean('durchaus!', true_values: [], false_values: []))
      assert_equal(false, Conversions.parse_boolean(false))
      assert_equal(false, Conversions.parse_boolean(false, true_values: [], false_values: [false, 'Nein']))
      assert_equal(false, Conversions.parse_boolean('Nein', true_values: [], false_values: [false, 'Nein']))
    end
  end

end