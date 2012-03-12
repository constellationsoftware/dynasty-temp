require 'simulation/sim_counter'

Given /^a user with the role of fed$/ do
  user = FactoryGirl.create(:user)
  user.roles = ['fed']
  user.save
end

When /^the user visits a stats page$/ do
  visit('/banking/stats')
end

Then /^the user will see "([^"]*)"$/ do |item|
  page.should have_xpath('//*', :text => Regexp.new(/#{item}:[\s]+\$*[\d]+/))
end

# simulation counter class tests
# these can be moved to traditional unit tests if required

Given /^a "([^"]*)" set to (\d+)$/ do |file, count|
  SimCounter.set(file, count)
end

When /^the "([^"]*)" is advanced (\d+)$/ do |file, inc|
  SimCounter.advance(file, inc)
end

Then /^the "([^"]*)" is set to (\d+)$/ do |file, expected_count|
  assert_equal SimCounter.count(file).to_i, expected_count.to_i
end

When /^the "([^"]*)" is retreated (\d+)$/ do |file, dec|
  SimCounter.retreat(file, dec)
end

When /^the "([^"]*)" is reset$/ do |file|
  SimCounter.reset(file)
end

# simulation counter tests
Given /^a weekly counter$/ do
  visit('/banking/counter')
end

When /^it's reset$/ do
  visit('/banking/counter_reset')
end

Then /^it returns (\d+)$/ do |count|
  page.should have_content count.to_s
end

When /^the counter set to (\d+)$/ do |count|
  visit("/banking/counter_set/#{count}")
end

When /^the counter is advanced (\d+)$/ do |count|
  visit("/banking/counter_advance/#{count}")
end

When /^the counter is retreated (\d+)$/ do |count|
  visit("/banking/counter_retreat/#{count}")
end

When /^the counter is incremented$/ do
  visit("/banking/counter_advance")
end

When /^the counter is decremented$/ do
  visit("/banking/counter_retreat")
end

