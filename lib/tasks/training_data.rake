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
  sql =  "INSERT INTO people ('height', 'weight', 'gender', 'created_at', 'updated_at')"
  sql += "  VALUES (?, ?, ?, #{now_function}, #{now_function})"

  st = ActiveRecord::Base.connection.raw_connection.prepare(sql)
  Person.transaction do
    attributes_array.each do |attributes|
      st.execute(attributes[:height], attributes[:weight], attributes[:gender])
    end
  end
  st.close
end

def now_function
  adapter = ActiveRecord::Base.connection_config[:adapter]
  case adapter
    when 'sqlite3'
      "DATETIME('now')"
    when 'postgresql'
      "now()"
    else
      raise "Database adapter not configured"
  end
end

namespace :training_data do
  desc 'Import records by reading JSON files from the command-line.'
  task :import, [:file] => :environment do |_task, args|
    attributes_array = get_attributes(args)
    add_people attributes_array
    StatisticsGenerator.new(Person).run
  end
end