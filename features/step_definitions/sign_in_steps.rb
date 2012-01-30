Given /^I visit the sign in page$/ do
  visit('/')
end

When /^I enter my proper credentials, "([^"]*)" and "([^"]*)"$/ do |username, password|
  @username = username
  
  within('#user_new.user_new') do
    fill_in('user_email', :with => username)
    fill_in('user_password', :with => password)
    click_on('Sign in')
  end

  # within('#user_new.nice') do
  #   fill_in('user_email', :with => 'exam@example.com')
  # end

  # ask('hang on...')
end

Then /^I should be on the landing page$/ do
  page.should have_content("Email: #{@username}")
  ask('hang on...')
end
