source 'http://rubygems.org'
source 'http://gems.github.com'

# Core Gems
gem 'rails', '3.1.1'
gem 'mysql2', '< 0.3.7'
gem 'enum_simulator', :git => 'git://github.com/FOMNick/enum_simulator.git'
gem 'activesupport', '~> 3.1.0'
gem 'execjs'
gem 'therubyracer'

# AR Improvements
gem 'squeel'
gem 'meta_search', '>= 1.1.0.pre'
gem 'inherited_resources'
gem 'responders'
gem 'has_scope'
gem 'kaminari'
gem 'uuidtools'
gem 'friendly_id', '~> 4.0.0.beta14' # for sluggable behavior

# Templating & View Helpers
gem 'eco'
gem 'haml'
gem 'spine-rails'
gem 'jquery-rails'
gem 'formtastic'

# Authentication & Permissions
gem 'devise'
gem 'cancan'
gem 'bcrypt-ruby', '>= 2.1.4'
gem 'devise_lastseenable', '>= 0.0.3'

# Servers, Workers, Sockets & Push
gem 'foreman'
gem 'thin'
gem 'juggernaut'
gem 'pusher'
gem 'pusher-client', :git => 'git://github.com/logankoester/pusher-client.git'
gem 'em-http-request' # required for async pusher requests
gem 'delayed_job', '< 3.0'

# Deployment
gem 'capistrano'
gem 'capistrano-ext'

# Misc
gem 'andand'
gem 'coffee-filter'
gem 'hpricot'
gem 'money', :git => 'git://github.com/FOMNick/money.git'
gem 'ruby_parser'
gem 'timecop'


group :development do
    # Debugging & Development
    gem 'ruby-debug19', :require => 'ruby-debug'
    gem 'rails-footnotes', '>= 3.7.5.rc4', :group => :development
end

group :production do

end

group :development, :test do
    gem 'rack'
end

group :assets do
    gem 'sass-rails'
    gem 'coffee-rails', '~> 3.1.0'
    gem 'uglifier'
    gem 'thin'
    gem 'zurb-foundation'
end

group :test do
    # Pretty printed test output
    gem 'turn', :require => false
end









