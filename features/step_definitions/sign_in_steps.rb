Given /^I visit the sign in page$/ do
  visit('/')
end

When /^I enter my (?:im)?proper credentials, "([^"]*)" and "([^"]*)"$/ do |user_name, user_password|
  FactoryGirl.create(:user)
  @user_name = user_name
  
  within('#new_user.new_user') do
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
  page.should have_content("Email: #{@user_name}")
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