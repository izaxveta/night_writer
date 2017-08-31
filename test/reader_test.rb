require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'
require './lib/reader'
require './lib/key'

class ReaderTest < Minitest::Test
  def test_reader_exists
    reader = Reader.new
    assert_instance_of Reader, reader
  end

  def test_ARGV0_reads_a_file
    assert_instance_of String, Reader.new.read
  end

end
