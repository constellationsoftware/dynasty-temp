source 'http://rubygems.org'
source 'http://gems.github.com'

# Core Gems
gem 'rails', '3.2.0'
gem 'mysql2'
gem 'enum_simulator', :git => 'git://github.com/FOMNick/enum_simulator.git'
gem 'activesupport', '~> 3.2.0'
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
gem 'haml'
gem 'ruby-haml-js'
gem 'barista'
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
#    gem 'pg'
end

group :development, :test do
    gem 'rack'
end


# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
    gem 'sass-rails', '~> 3.2.3'
    gem 'coffee-rails', '~> 3.2.1'
    gem 'uglifier', '>=1.0.3'
    gem 'zurb-foundation'
end

group :test do
    # Pretty printed test output
    gem 'turn', :require => false
    gem 'cucumber-rails', '1.2.1'
    gem 'rspec-rails', '2.7.0'
    gem 'database_cleaner', '0.7.0'
    gem 'factory_girl', '2.3.2'
end
