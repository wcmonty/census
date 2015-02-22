Given(/^I have a file named "(.+)" with the following data:$/) do |filename, text|
  fail "File already exists: #{filename}" if File.exist?(filename)
  File.new(filename, 'w').tap{|file| file.write(text)}.close
end

Given(/^I delete the file named "(.+)"$/) do |filename|
  File.delete(filename)
end

When(/^I import the data from "(.*)"$/) do |filename|
  name = "training_data:import"
  task = Rake.application[name]
  task.reenable
  task.invoke filename
end

Then(/^there should be the following "([^"]*)" records:$/) do |record, table|
  # table is a table.hashes.keys # => [:height, :weight, :gender]
  klass = record.classify.constantize
  table.hashes.each do |hash|
    expect(klass.where(hash).count).to be == 1
  end
end