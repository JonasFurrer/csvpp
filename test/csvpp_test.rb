require "test_helper"

class CSVPPTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil CSVPP::VERSION
  end

  def test_simple_parse
    results = CSVPP.parse(
      input: 'test/sample_inputs/simple.txt',
      format: 'test/sample_formats/simple.json'
    )

    assert_equal 2, results.count

    r1, r2 = results

    assert_equal 34, r1['v1']
    assert_equal 99, r2['v1']

    assert_equal "foobar", r1['v2']
    assert_equal "hi  there", r2['v2']

    assert_equal 1, r1['line_number']
    assert_equal 2, r2['line_number']
  end

  def test_simple_parse_yielding_open_struct
    results = CSVPP.parse(
      input: 'test/sample_inputs/simple.txt',
      format: 'test/sample_formats/simple.json'
    ) { |attr| OpenStruct.new(attr) }

    assert_equal 2, results.count

    r1, r2 = results

    assert_instance_of OpenStruct, r1
    assert_instance_of OpenStruct, r2

    assert_equal 34, r1.v1
    assert_equal 99, r2.v1

    assert_equal "foobar", r1.v2
    assert_equal "hi  there", r2.v2
  end

  def test_simple_parse_str
    input_str = File.read('test/sample_inputs/simple.txt')
    format_str = File.read('test/sample_formats/simple.json')

    results = CSVPP.parse_str(
      input: input_str,
      format: format_str
    )

    assert_equal 2, results.count

    r1, r2 = results

    assert_equal 34, r1['v1']
    assert_equal 99, r2['v1']

    assert_equal "foobar", r1['v2']
    assert_equal "hi  there", r2['v2']

    assert_equal 1, r1['line_number']
    assert_equal 2, r2['line_number']
  end

  def test_simple_json
    input_str = File.read('test/sample_inputs/simple.txt')
    format_str = File.read('test/sample_formats/simple.json')

    json = CSVPP.json(
      input: input_str,
      format: format_str
    )

    assert_instance_of String, json

    hash = Oj.load(json)
    r1, r2 = hash.fetch('vars')

    assert_equal 34, r1['v1']
    assert_equal 99, r2['v1']

    assert_equal "foobar", r1['v2']
    assert_equal "hi  there", r2['v2']

    assert_equal 1, r1['line_number']
    assert_equal 2, r2['line_number']
  end

end
