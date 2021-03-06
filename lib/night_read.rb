require_relative 'reader'
require_relative 'braille-to-alpha'
class NightRead
  def initialize
    formatted_alpha = BrailleToAlpha.new.convert_capitals
    message = Reader.new
    message = message.read
    to_alpha = File.open(ARGV[1], 'w')
    to_alpha.write(formatted_alpha)
    puts "Created '#{ARGV[1]}' containing #{message.length-1} characters."
  end
end

NightRead.new
