def sign_up(user_name, user_email, user_password)
  within('#user_new.nice') do
    fill_in('user_name', :with => user_name)
    fill_in('user_email', :with => user_email)
    fill_in('user_password', :with => user_password)
    fill_in('user_password_confirmation', :with => user_password)
    click_on('Sign up')
  end
end

def sign_in(user_email, user_password)
  within('#user_new.user_new') do
    fill_in('user_email', :with => user_email)
    fill_in('user_password', :with => user_password)
    click_on('Sign in')
  end
end


Given /^I am user, "([^"]*)", "([^"]*)", "([^"]*)"$/ do |user_name, user_email, user_password|
  visit('/')
  sign_up(user_name, user_email, user_password)
end

Given /^I am signed in as, "([^"]*)", "([^"]*)", "([^"]*)"$/ do |user_name, user_email, user_password|
  visit('/')
  sign_in(user_email, user_password)
end

Given /^I am managing a team$/ do
  # too specific
  visit('/teams/2/manage#roster')
end

Then "I can navigate the following tabs:" do |table|
  table.raw.each do |tab, content|
    click_on(tab)
    page.should have_content(content)
  end
end