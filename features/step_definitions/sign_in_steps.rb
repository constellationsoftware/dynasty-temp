Given /^I visit the sign in page$/ do
  visit('/')
end

When /^I enter my (?:im)?proper credentials, "([^"]*)" and "([^"]*)"$/ do |user_name, user_password|
  @username = username
  
  within('#user_new.user_new') do
    fill_in('user_email', :with => user_name)
    fill_in('user_password', :with => user_password)
    click_on('Sign in')
  end

  # within('#user_new.nice') do
  #   fill_in('user_email', :with => 'exam@example.com')
  # end

  # ask('hang on...')
end

Then /^I should be on the landing page$/ do
  page.should have_content("Email: #{@username}")
  click_on('Sign Out')
  # ask('hang on...')
end

Then /^I should not be on the landing page$/ do
  # ask('hang on...')
  page.should have_content("Invalid email or password.")
 
  # ask('hang on...')
end

# proper email address? is this js?

# invalid creds put email addr in both email fields
# similar thing with password fields



# sign up is a feature

# home button