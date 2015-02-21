class LocalFileOpener

  def initialize(filename)
    @filename = filename
  end

  def run
    puts "Opening filename: #{filename}"
  end

  protected

  attr_reader :filename
end