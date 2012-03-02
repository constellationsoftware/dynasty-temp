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


When /^a simple transaction is posted$/ do
  Ledger.post( :description => 'Simple transaction test', :entries => [[10,0],[-10,1]] )
end

Then /^the ledger stays balanced$/ do
  assert_equal Ledger.balanced?, true
end

When /^a payroll transaction is posted for \$(\d+) for team (\d+) for week (\d+)$/ do |amount, team, week|
  Ledger.post_payroll( amount, team, week )
end

When /^a dynasty dollar transfer is posted for \$(\d+) from team (\d+) to team (\d+)$/ do |amount, team_from, team_to|
  Ledger.post_dynasty_dollar_transfer(amount, team_from, team_to)
end

When /^a dynasty dollar purchase is posted for \$(\d+) to team (\d+)$/ do |amount, team|
  Ledger.post_dynasty_dollar_purchase(amount, team)
end

When /^a revenue share transaction is posted for \$(\d+) to team (\d+)$/ do |amount, team|
  Ledger.post_revenue_share(amount, team)
end

When /^a new team transaction is posted for \$(\d+) for team (\d+)$/ do |amount, team|
  Ledger.post_new_team(amount, team)
end
