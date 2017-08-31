require_relative 'key'
require_relative 'reader'
# require 'pry'; binding.pry

class AlphaToBraille
  attr_reader :array_top, :array_middle, :array_bottom, :top_array, :middle_array,
              :bottom_array, :read, :shifted_letters, :shift_capitals, :output
  attr_accessor :content

  def initialize
    read_file = Reader.new
    @content = read_file.read
  end

  def shift_capitals
    shifted_letters = []
    @content.split("").each do |letter|
      if ('A'..'Z').member?(letter)
        shifted_letters << ":shift"
        shifted_letters << letter.downcase
      else
        shifted_letters << letter
      end
    end
    shifted_letters
  end

  def braille(block)
    shifted_letters = shift_capitals
    shifted_letters.delete("\n")
    translation = shifted_letters.map { |letters| BRAILLE.values_at(letters)[0][block] }.join('')
    translation
  end

  def slice_string(string_position)
    array_position = []
    count = string_position.length
      while count > 0
        slice = string_position.slice!(0..79)
        array_position << slice
        count -= 80
      end
      array_position
  end

  def braille_slices
    array_top = braille(0)
    array_middle = braille(1)
    array_bottom = braille(2)
    @top_array = slice_string(array_top)
    @middle_array = slice_string(array_middle)
    @bottom_array = slice_string(array_bottom)
  end

  def blend_array
    braille_slices
    blend = []
    until @top_array.empty?
      blend << @top_array.shift
      blend << "\n"
      blend << @middle_array.shift
      blend << "\n"
      blend << @bottom_array.shift
      blend << "\n\n"
    end
    blend.join
  end
end
