require_relative '../file_opener'
require 'json'

def parse_json(contents)
  begin
    JSON.parse(contents)
  rescue
    puts 'Invalid JSON'
    {}
  end
end

namespace :training_data do
  desc 'Import records by reading JSON files from the command-line.'
  task :import, [:file] => :environment do |_task, args|
    contents = FileOpener.new(args[:file]).contents
    hash = parse_json(contents)
    puts hash
  end
end