require_relative 'key'
require_relative 'reader'

class Playground
  attr_reader :content, :array_top, :array_middle, :array_bottom,
              :top_array, :middle_array, :bottom_array, :read, :shifted_letters, :shift_capitals
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
    #Braille translator. Block argument points to index of specific key value (0-top, 1-mid, 2-bottom)
    shifted_letters = shift_capitals
    shifted_letters.delete("\n")
    x = shifted_letters.map { |letters| BRAILLE.values_at(letters)[0][block] }.join('')
    x
  end

  def slice_string(string_position)
    #This method slices strings into perfect 80 position arrays.
    #Pushing them into a larger parent array.
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
    #Takes translated braille and slices into arrays of 80 character arrays
    array_top = braille(0)
    array_middle = braille(1)
    array_bottom = braille(2)
    @top_array = slice_string(array_top)
    @middle_array = slice_string(array_middle)
    @bottom_array = slice_string(array_bottom)
  end

  def blend_array
    #Takes top mid and bottom arrays of arrays and orders them into larger parent array
    #with 'new line' commands based on how they should appear from top to bottom on txt file
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

  def output
    stuff = blend_array

    message = Reader.new
    message = message.read
    uhh = File.open(ARGV[1], 'w')
    uhh.write(stuff)
  end

end

playground = Playground.new
playground.output
