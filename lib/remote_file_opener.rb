class RemoteFileOpener

  def initialize(uri)
    @uri = uri
  end

  def contents
    puts "Opening uri: #{uri}"
  end

  protected

  attr_reader :uri
end