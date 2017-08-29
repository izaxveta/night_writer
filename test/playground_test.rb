require 'minitest/autorun'
require 'minitest/pride'
require './playground'
require './key'

class PlaygroundTest < Minitest::Test
  def test_that_it_exists
    playground = Playground.new

    assert_instance_of Playground, playground
  end

  def test_it_starts_with_content
    playground = Playground.new

    assert_instance_of String, playground.content
  end

  def test_conversion_to_braille
    # skip
    playground = Playground.new
    translation = playground.braille(0)

    assert_instance_of String, translation
  end

  def test_string_slices_to_array
    skip
    playground = Playground.new
    translation = playground.braille(0)
    formatted_translation = playground.slice_string(translation)
    expected = []

    assert_equal expected, formatted_translation
  end




end
