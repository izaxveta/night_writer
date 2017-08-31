class Reader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end
