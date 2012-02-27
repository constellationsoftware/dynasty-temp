Given /^I visit the sign up page$/ do
  visit('/')
end

When /^I enter valid info, "([^"]*)" and "([^"]*)" and "([^"]*)"$/ do |user_name, user_email, user_password|
  within('#new_user.nice') do
    fill_in('user_name', :with => user_name)
    fill_in('user_email', :with => user_email)
    fill_in('user_password', :with => user_password)
    fill_in('user_password_confirmation', :with => user_password)
    click_on('Sign up')
  end
  # ask('hang on...')
end
