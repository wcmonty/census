class FileOpener

  def initialize(filename)
    @filename = filename
  end

  def run
    if is_a_valid_uri?
      RemoteFileOpener.new(filename).run
    else
      LocalFileOpener.new(filename).run
    end
  end

  protected

  attr_reader :filename

  private

  def is_a_valid_uri?
    uri = URI(filename)
    %w(http https).include? uri.scheme
  end
end