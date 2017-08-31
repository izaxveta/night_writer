gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/braille_to_alpha'
require './lib/reader'
require './lib/key'

class TestBrailleToAlpha < Minitest::Test

  def test_instance_of_reader_file
    translation = BrailleToAlpha.new
    assert_instance_of String, translation.content
  end

  def test_starts_with_empty_strings
    translation = BrailleToAlpha.new
    assert_equal "", translation.top
    assert_equal "", translation.mid
    assert_equal "", translation.bottom
  end

  def test_splitter_splits_shit
    skip
    translation = BrailleToAlpha.new
    split = translation.splitter
    assert_equal "", split.top
  end

  def test_braille_to_alpha_returns_translated_values
    translation = BrailleToAlpha.new
    expected = translation.braille_to_alpha(["O.","..",".."])
    assert_equal ['a'], expected
  end

  def test_translate_returns_string
    translation = BrailleToAlpha.new
    expected = translation.translate
    assert_equal ":shiftsomething :shiftnice", expected
  end

  def test_converts_shift_to_capitals
    translation = BrailleToAlpha.new
    expected = translation.convert_capitals
    assert_equal "Something Nice", expected
  end

end
