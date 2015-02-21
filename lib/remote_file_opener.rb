class RemoteFileOpener

  def initialize(uri)
    @uri = uri
  end

  def run
    puts "Opening uri: #{uri}"
  end

  protected

  attr_reader :uri
end