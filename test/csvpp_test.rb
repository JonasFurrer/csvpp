require "test_helper"

class CSVPPTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil CSVPP::VERSION
  end

  def test_parse
    results = CSVPP.parse(
      'test/sample_inputs/simple.txt',
      format: 'test/sample_formats/simple.json'
    )

    assert_equal 2, results.count

    r1, r2 = results
    assert_equal 34, r1['v1']
    assert_equal 99, r2['v1']

    assert_equal "foobar", r1['v2']
    assert_equal "hi  there", r2['v2']
  end
end
