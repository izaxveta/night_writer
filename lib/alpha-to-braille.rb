require_relative 'key'
require_relative 'reader'

class AlphaToBraille
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

  def alpha_by_80(position)
    array_position = []
    count = position.length
      while count > 0
        slice = position.slice!(0..79)
        array_position << slice
        count -= 80
      end
      array_position
  end

  def braille_slices
    top_line = braille(0)
    middle_line = braille(1)
    bottom_line = braille(2)
    @top = alpha_by_80(top_line)
    @middle = alpha_by_80(middle_line)
    @bottom = alpha_by_80(bottom_line)
  end

  def blend_braille
    braille_slices
    blend = []
    until @top.empty?
      blend << @top.shift
      blend << "\n"
      blend << @middle.shift
      blend << "\n"
      blend << @bottom.shift
      blend << "\n\n"
    end
    blend.join
  end
end
