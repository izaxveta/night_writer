require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'
require './lib/reader'
require './lib/key'

class TestNightWrite < Minitest::Test
  def test_it_exists
    braille = NightWriter.new
    assert_instance_of NightWriter, braille
  end

  def test_it_gets_braille
    braille = NightWriter.new
    assert_instance_of String, braille.formatted_braille
  end

  def test_reads_message
    braille = NightWriter.new
    assert_equal "Th\n", braille.message
  end
end
