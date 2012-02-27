Given /^a user role, "([^"]*)"$/ do |role|
  user = FactoryGirl.create(:user)
  user.roles = [role]
  user.save
  
  # puts "USER: #{user}"
  
  visit('/')
  within('#new_user.new_user') do
    fill_in('user_email', :with => user.email)
    fill_in('user_password', :with => 'password')
    click_on('Sign in')
  end
  # ask('loggin')
end

When /^I visit a user role test page, "([^"]*)"$/ do |page|
  visit("/test_roles/#{page}")
  # ask('test')
end

Then /^I should see the status, "([^"]*)"$/ do |status|
  if status == 'succeed'
    page.should have_content('SUCCESS')
  else
    page.should have_content('FAIL')
  end
  # ask('result')
end
