Given(/^I have a file named "(.+)" with the following data:$/) do |filename, text|
  fail "File already exists: #{filename}" if File.exist?(filename)
  File.new(filename, 'w').tap{|file| file.write(text)}.close
end

Given(/^I delete the file named "(.+)"$/) do |filename|
  File.delete(filename)
end


When(/^I import the data from "(.*)"$/) do |filename|
  invoke_task(filename)
end

Then(/^there should be the following "([^"]*)" records:$/) do |record, table|
  # table is a table.hashes.keys # => [:height, :weight, :gender]
  klass = record.classify.constantize
  table.hashes.each do |hash|
    replace_nils(hash)
    expect(klass.where(hash).count).to be >= 1
  end
end


Then(/^there should be (\d+) "(.+)" record(?:s)$/) do |number, record|
  klass = record.classify.constantize
  expect(klass.count).to eq number.to_i
end

When(/^I import the data from a file that does not exist$/) do
  filename = "#{Time.now.to_i}.#{Random.rand(1000000000)}.bar"
end

def replace_nils(hash)
  hash.each do |key, value|
    hash[key] = nil if value == 'nil'
  end
end

def invoke_task(filename)
  task = Rake.application[task_name]
  task.reenable
  task.invoke filename
end

def task_name
  "training_data:import"
end
