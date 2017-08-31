gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_read'
require './lib/reader'
require './lib/key'

class TestNightRead < Minitest::Test

  def test_it_exists
    alpha = NightRead.new
    assert_instance_of NightRead, alpha
  end

  def test_night_read_gets_string
    alpha = NightRead.new
    assert_instance_of String, alpha.formatted_alpha
  end

  def test_to_alpha_writes_braille_and_returns_characters
    alpha = NightRead.new
    expected = alpha.to_alpha.write('Th')
    assert_equal 2, expected

  end

  def test_message_reads_braille
    alpha = NightRead.new
    expected = alpha.message
    assert_equal "...OO.
..OOOO
.OO...
", expected
  end

end
