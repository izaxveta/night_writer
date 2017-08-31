require_relative 'reader'
require_relative 'alpha-to-braille'
class NightWrite
  def initialize
    formatted_braille = AlphaToBraille.new.blend_braille
    message = Reader.new
    message = message.read
    to_braille = File.open(ARGV[1], 'w')
    to_braille.write(formatted_braille)
    puts "Created '#{ARGV[1]}' containing #{message.length-1} characters."
  end

end

NightWrite.new
