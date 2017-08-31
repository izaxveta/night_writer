require_relative 'reader'
require_relative 'key'
class BrailleToAlpha
  attr_reader :content, :top, :mid, :bottom
  def initialize
    read_file = Reader.new
    @content = read_file.read
    @top = ""
    @mid = ""
    @bottom = ""
  end

  def splitter
    formatted_braille = @content.split("\n")
    until formatted_braille.empty? do
      @top << formatted_braille.shift
      @mid << formatted_braille.shift
      @bottom << formatted_braille.shift
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
    final_message = conversion.split(":").map do |word|
      if word.include?("shift")
        word.slice! "shift"
        word.capitalize
      else
        word
      end
    end
    final_message.join('')
  end
end
