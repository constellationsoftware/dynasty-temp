Given /^I own a team$/ do
  user = FactoryGirl.create(:user)
  user.roles = ['team_owner']
  user.save
end


When /^I visit team stats page$/ do
  visit('/banking/team_stats/1')
end

Then /^I should see "([^"]*)"$/ do |item|
  page.should have_xpath('//*', :text => Regexp.new(/#{item}:[\s]+\$[\d]+/))
end


class Account
  def initialize(begining_balance=0)
    @balance = begining_balance
  end
  
  def deposit(amount)
    puts "AMOUNT: #{amount}"
    puts "BALANCE: #{@balance}"
    @balance += amount
  end
  
  def balance
    @balance
  end
end

When /^I deposit \$(\d+) to my account$/ do |amount|
  puts "AMOUNT: #{amount}"
  @account = Account.new
  @account.deposit(amount.to_i)
end

Then /^I should see my account increase \$(\d+)$/ do |amount|
  @account.balance.should eq(amount.to_i),
    "Expected the balance to be #{amount} but it was #{@account.balance}"
end

Then /^I should see issued dynasty dollars increase \$(\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
