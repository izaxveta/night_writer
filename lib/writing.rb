require_relative 'night_writer'
require_relative 'key'
require_relative 'reader'

class Writer
  def initialize
    @writer = NightWriter.new
  end

  def output
    stuff = writer.alpha_to_braille
    message = Reader.new
    message = message.read
    File.write(ARGV[1], stuff)

    puts "Created '#{stuff}' containing..."
  end

end
