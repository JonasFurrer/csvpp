$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "csvpp"

require "minitest/autorun"
require "minitest/pride"

def assert_pairs_match(test_data)
  test_data.each do |test_pair|
    input = test_pair.first
    expected = test_pair.last
    observed = yield(input)
    assert_equal expected, observed
  end
end