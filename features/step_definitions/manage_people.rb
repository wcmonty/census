Given(/^I visit "(.+)"$/) do  |url|
  visit url
end

Given(/^I click on the "(.*)" button$/) do |button_name|
  click_on button_name
end

Given(/^I fill out the form with the following information:$/) do |table|
  # table is a table.hashes.keys # => [:gender, :height, :weight]
  hash = table.hashes.first
  select hash[:gender], from: 'person[gender]'
  fill_in 'person[height]', with: hash[:height]
  fill_in 'person[weight]', with: hash[:weight]
end

Then(/^I (should|should not) see a success message$/) do |context|
  if context == 'should'
    expect(page).to have_content "Person was successfully created."
  else
    expect(page).not_to have_content "Person was successfully created."
  end
end

And(/^I select the (.+) from "(.+)"$/) do |option, selection|
  select option, from: selection
end

And(/^I fill the "(.+)" field with (.*)$/) do |field, value|
  fill_in field, with: value
end