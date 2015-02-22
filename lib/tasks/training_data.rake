require_relative '../sqlite3_preparer'
require_relative '../postgresql_preparer'

def get_attributes(args)
  contents = FileOpener.new(args[:file]).contents

  begin
    contents['people'].map { |hash| map_json_fields(hash['person']) }
  rescue
    puts "JSON incorrectly formatted"
    []
  end
end

def map_json_fields(person)
  {
      height: convert_height(person['height']),
      weight: convert_weight(person['weight']),
      gender: person['gender']
  }
end

def convert_height(feet)
  (feet * 12).round rescue nil
end

def convert_weight(pounds)
  pounds.round rescue nil
end

def add_people(attributes_array)
  preparer = get_preparer.new
  Person.transaction do
    attributes_array.each do |attributes|
      preparer.execute(attributes[:height], attributes[:weight], attributes[:gender])
    end
  end
  preparer.close
end

def get_preparer
  adapter = ActiveRecord::Base.connection_config[:adapter]
  case adapter
    when 'sqlite3'
      Sqlite3Preparer
    when 'postgresql'
      PostgresqlPreparer
    else
      raise "Database adapter not implemented"
  end
end

namespace :training_data do
  desc 'Import records by reading JSON files from the command-line.'
  task :import, [:file] => :environment do |_task, args|
    begin
      attributes_array = get_attributes(args)
      add_people attributes_array
    rescue
      puts "Usage: [bundle exec] rake training_data:import[filename]"
    end
    StatisticsGenerator.new(Person).run
  end

  task :clear => :environment do
    Person.delete_all
    StatisticsGenerator.new(Person).run
  end
end