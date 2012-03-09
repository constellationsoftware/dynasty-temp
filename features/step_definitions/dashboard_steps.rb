def sign_up(user_name, user_email, user_password)
  FactoryGirl.create(:user)

  within('#new_user.nice') do
    fill_in('user_name', :with => user_name)
    fill_in('user_email', :with => user_email)
    fill_in('user_password', :with => user_password)
    fill_in('user_password_confirmation', :with => user_password)
    click_on('Sign up')
  end
end

def sign_in(user_email, user_password)
  user = FactoryGirl.create(:user)
  user.roles = ['team_owner']
  user.save

  team = FactoryGirl.create(:user_team)
  team.user_id = user.id
  @team_id = team.id
  team.save
  
  player = FactoryGirl.create(:player_team_record)
  player.user_team_id = team.id
  player.save

  within('#new_user.new_user') do
    fill_in('user_email', :with => user_email)
    fill_in('user_password', :with => user_password)
    click_on('Sign in')
  end
  # ask('hang on...')
end


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