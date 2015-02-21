class LocalFileOpener

  def initialize(filename)
    @filename = filename
  end

  def contents
    File.read(filename)
  end

  protected

  attr_reader :filename
end