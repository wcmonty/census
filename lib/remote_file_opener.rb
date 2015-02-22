class RemoteFileOpener
  include HTTParty

  def initialize(uri)
    @uri = uri
  end

  def contents
    response = HTTParty.get(uri)
    response.body
  end

  protected

  attr_reader :uri
end