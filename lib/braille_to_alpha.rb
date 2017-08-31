require_relative 'key'
require_relative 'reader'

class BrailleToAlpha
  attr_reader :content, :mid, :bottom, :top 
  def initialize
    read_file = Reader.new
    @content = read_file.read
    @top = ""
    @mid = ""
    @bottom = ""
  end

  def splitter
    split_braille = @content.split("\n")
    until split_braille.empty? do
      @top << split_braille.shift
      @mid << split_braille.shift
      @bottom << split_braille.shift
    end
  end

  def braille_to_alpha(key)
    ALPHA.values_at(key)
  end

  def translate
    splitter
    @translation = ""
    braille = []
    until @top.empty? do
      braille << @top.slice!(0..1)
      braille << @mid.slice!(0..1)
      braille << @bottom.slice!(0..1)
      value = braille_to_alpha(braille)
      letter = value[0]
      @translation << letter
      braille = []
    end
    @translation
  end

  def convert_capitals
    conversion = translate
    final_array = conversion.split(" ").map do |word|
      if word.include?(":shift")
        word.slice! ":shift"
        word.capitalize
      else
        word
      end
    end
    final_array.join(' ')
  end

end
