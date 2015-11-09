require 'minitest/autorun'
require './lib/diagnostics'
require 'pry'

class DiagnosticsTest < Minitest::Test
  def test_it_outputs_pre_tagged_data
    d = Diagnostics.new
    request = {"Key 1" => "Value 1", "Key 2" => "Value 2"}

    starts_and_ends_with_pre_tags = /^<pre>(.*)<\/pre>$/m
    assert_match starts_and_ends_with_pre_tags, d.output_diagnostics(request)
  end

  def test_it_outputs_key_value_pairs_from_request
    d = Diagnostics.new
    request = {"Key 1" => "Value 1", "Key 2" => "Value 2"}
    output = d.output_diagnostics(request)

    assert_match /Key 1: Value 1/, output
    assert_match /Key 2: Value 2/, output
  end

  def test_it_skips_a_key_named_Param
    d = Diagnostics.new
    request = {"Key 1" => "Value 1", "Param" => "DIE!!", "Key 2" => "Value 2"}
    output = d.output_diagnostics(request)

    refute_match /Param: DIE!!/, output
  end

  def test_it_skips_a_key_named_Value
    d = Diagnostics.new
    request = {"Key 1" => "Value 1", "Value" => "DIE!!", "Key 2" => "Value 2"}
    output = d.output_diagnostics(request)

    refute_match /Value: DIE!!/, output
  end

  def test_it_outputs_one_key_value_set_per_line
    d = Diagnostics.new
    request = {"Key 1" => "Value 1", "Key 2" => "Value 2"}
    output = d.output_diagnostics(request)

    expected = "<pre>\n  Key 1: Value 1\n  Key 2: Value 2\n</pre>"
    assert_equal expected, output
  end
end
