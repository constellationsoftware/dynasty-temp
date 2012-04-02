def log(in_or_out = 'in')
    "(?:log|sign)[-| ]{1}?#{in_or_out.to_s}"
end

def logged(in_or_out = 'in')
    "(?:logged|signed)[-| ]{1}#{in_or_out.to_s}"
end

# assume the login page is the generic user login page
Transform /^#{log 'in'}$/ do |page|
    'user login'
end

Given /^I exist as a (.+)$/ do |role|
    send "create_#{role}"
end

Given /^I do not exist as an? user$/ do
    delete_user
    create_guest
end

Given /^I #{log 'in'}$/ do
    log_in(true)
end

Given /^I am #{logged 'in'}$/ do
    create_user
    log_in
end

Given /^I am #{logged 'in'} as an? (.+)(?:, unless I(?:'| a)m a (.+))/ do |role, as_user|
    send "create_#{role}"
    log_in(@user.role === as_user)
end

Given /^I am (?:not #{logged 'in'}|#{logged 'out'})$/ do
    visit(send "destroy_#{@user.role}_session_path")
end

When /^(?:I )?fill in "([^"]*)" with "([^"]*)"$/ do |key, value|
    @user = @user.merge Hash[key, value]
end

Then /^I should be #{logged 'in'}$/ do
    page.should have_content(I18n.t :signed_in, :attribute => @user.email, :scope => :nav)
    page.should_not have_content(I18n.t :signed_out, :scope => :nav)
end

Then /^I should be #{logged 'out'}$/ do
    page.should_not have_content(I18n.t :signed_in, :attribute => @user.email, :scope => :nav)
    page.should have_content(I18n.t :signed_out, :scope => :nav)
end

Then /^I should see an invalid #{log 'in'} message$/ do
    page.should have_content(I18n.t :invalid, :scope => %w( devise failure ))
end

def log_in(as_user = false)
    role = as_user ? 'user' : @user.role
    # go to the appropriate log in route, overriding as a user if as_user does not evaluate to false
    visit(send "new_#{role}_session_path")
    # fill out credentials
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    # click submit button
    within '#content form.login' do
        click_button I18n.t :submit, :scope => %w( formtastic actions user)
    end
end

def create_user
    @user = FactoryGirl.create(:user)
end

def create_guest
    @user = FactoryGirl.build(:user,
        :first_name => 'Anonymous',
        :last_name => '',
        :password => 'please',
        :password_confirmation => 'please',
        :role => 'guest'
    )
end

def delete_user
    @user.destroy unless @user.nil?
end

class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
        @@shared_connection || retrieve_connection
    end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
