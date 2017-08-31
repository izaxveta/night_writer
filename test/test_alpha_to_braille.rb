gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'
require './lib/reader'
require './lib/key'

class AlphaToBrailleTest < Minitest::Test

  def test_night_writer_class
    writer = AlphaToBraille.new
    assert_instance_of AlphaToBraille, writer
  end

  def test_pulls_read_file_from_reader_class
    skip
    writer = AlphaToBraille.new
    assert_instance_of Reader, writer

  end

  def test_shift_capitals_returns_shifted_letters
    writer = AlphaToBraille.new
    writer.content = 'A'
    assert_equal [':shift', 'a'], writer.shift_capitals
  end

  def test_braille_returns_translation
    writer = AlphaToBraille.new
    writer.content = 'Hello'
    expected_1 = "..0.0.0.0.0."
    expected_2 = "..00.00.0..0"
    expected_3 = ".0....0.0.0."
    assert_equal expected_1, writer.braille(0)
    assert_equal expected_2, writer.braille(1)
    assert_equal expected_3, writer.braille(2)
  end

  def test_slice_string_slices_string
    writer = AlphaToBraille.new
    writer.content = 'HelloHelloHelloHelloHelloHelloHelloHelloHelloHello'

    a =  writer.braille(0)
    b =  writer.braille(1)
    c =  writer.braille(2)

    expected_1 = ["..0.0.0.0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.", "0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.0.0."]
    expected_2 = ["..00.00.0..0..00.00.0..0..00.00.0..0..00.00.0..0..00.00.0..0..00.00.0..0..00.00.", "0..0..00.00.0..0..00.00.0..0..00.00.0..0"]
    expected_3 = [".0....0.0.0..0....0.0.0..0....0.0.0..0....0.0.0..0....0.0.0..0....0.0.0..0....0.", "0.0..0....0.0.0..0....0.0.0..0....0.0.0."]

    assert_equal expected_1, writer.slice_string(a)
    assert_equal expected_2, writer.slice_string(b)
    assert_equal expected_3, writer.slice_string(c)
  end

  def test_braille_slices_returns_top_mid_and_bottom_arrays_translated
    writer = AlphaToBraille.new
    writer.content = 'HelloHelloHelloHelloHelloHelloHelloHelloHelloHello'
    writer.braille_slices
    expected_1 = ["..0.0.0.0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.", "0.0...0.0.0.0.0...0.0.0.0.0...0.0.0.0.0."]
    expected_2 = ["..00.00.0..0..00.00.0..0..00.00.0..0..00.00.0..0..00.00.0..0..00.00.0..0..00.00.", "0..0..00.00.0..0..00.00.0..0..00.00.0..0"]
    expected_3 = [".0....0.0.0..0....0.0.0..0....0.0.0..0....0.0.0..0....0.0.0..0....0.0.0..0....0.", "0.0..0....0.0.0..0....0.0.0..0....0.0.0."]
    assert_equal expected_1, writer.top_array
    assert_equal expected_2, writer.middle_array
    assert_equal expected_3, writer.bottom_array

  end

  def test_blended_array_returns_string_formatted_as_braille
    writer = AlphaToBraille.new
    writer.content = 'Hello'
    expected = "..0.0.0.0.0.
..00.00.0..0
.0....0.0.0.

"

    assert_equal expected, writer.blend_array

  end

  def test_output_returns_number_of_braille_characters_correctly
    writer = AlphaToBraille.new
    writer.content = 'HelloHello'
    assert_equal 76 , writer.output
  end

end
