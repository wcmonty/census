class FileOpener

  def initialize(filename)
    @filename = filename
    @opener = klass.new(filename)
  end

  def contents
    parse_json(get_contents)
  end

  protected

  attr_reader :filename, :opener

  private

  def get_contents
    begin
      opener.contents
    rescue
      puts "Could not open #{filename}"
      empty_json
    end
  end

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
      JSON.parse(empty_json)
    end
  end

  def empty_json
    '{"people": []}'
  end
end