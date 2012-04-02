Given /^I am user, "([^"]*)", "([^"]*)", "([^"]*)"$/ do |user_name, user_email, user_password|
  visit('/')
  sign_up(user_name, user_email, user_password)
end

Given /^I am signed in as, "([^"]*)", "([^"]*)", "([^"]*)"$/ do |user_name, user_email, user_password|
  # Capybara::Server.manual_host = 'bros.dynasty.dev'
  # Capybara.server_port = 8888
  visit('/')
  sign_in(user_email, user_password)
end

Given /^I am managing a team$/ do
  # puts "TEAM_ID: #{@team_id}"
  # visit("/teams/#{@team_id}/manage#roster")
  # visit("/teams/1/manage#roster")
  # ask('hang on...')
  
  # too specific
  # should be
  # click_on('Manage Team')

  # what's with the jerks sub-domain?
  # visit('/')
  # sign_in("testuser@example.com", "password")
  # Capybara.default_host = "bros.#{Capybara::Server.manual_host}"
  # visit("/teams/#{@team_id}/manage#roster")
  ask('Hold on...')
  click_on('Manage Team')
end

Then "I can navigate the following tabs:" do |table|
  # session[:user_team_id] = @team_id

  table.raw.each do |tab, content|
    click_on(tab)
    page.should have_content(content)
  end
end
