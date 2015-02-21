class FileOpener

  def initialize(filename)
    @filename = filename
    @opener = klass.new(filename)
  end

  def contents
    parse_json opener.contents
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

  def parse_json(contents)
    begin
      JSON.parse(contents)
    rescue
      puts 'Invalid JSON'
      {}
    end
  end
end