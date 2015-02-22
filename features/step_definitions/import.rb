Given(/^I have a file named "(.+)" with the following data:$/) do |filename, text|
  puts Person.all
  fail "File already exists: #{filename}" if File.exist?(filename)
  File.new(filename, 'w').write(text)
end

Given(/^I delete the file named "(.+)"$/) do |filename|
  File.delete(filename)
end

When(/^I import the data from "(.*)"$/) do |filename|
  require "rake"
  load 'Rakefile'
  Rake.application.init
  Rake.application.load_rakefile
  Rake.application.invoke_task("training_data:import[#{filename}]")
end

Then(/^there should be a "([^"]*)" record with the following attributes:$/) do |record, table|
  # table is a table.hashes.keys # => [:height, :weight, :gender]
  binding.pry
  klass = record.classify.constantize
  table.hashes.each do |hash|
    expect(klass.where(hash).count).to be 1
  end
end