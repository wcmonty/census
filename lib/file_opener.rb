require_relative 'remote_file_opener'
require_relative 'local_file_opener'

class FileOpener

  def initialize(filename)
    @filename = filename
    @opener = klass.new(filename)
  end

  def run
    opener.run
  end

  protected

  attr_reader :filename, :opener

  private

  def is_a_valid_uri?
    uri = URI(filename)
    %w(http https).include? uri.scheme
  end

  def klass
    if is_a_valid_uri?
      RemoteFileOpener
    else
      LocalFileOpener
    end
  end
end