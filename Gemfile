source 'http://rubygems.org'
source 'http://gems.github.com'

# Core Gems
gem 'rails', '3.2.0'
gem 'mysql2'
gem 'activesupport', '~> 3.2.0'
gem 'execjs'
gem 'therubyracer'
gem 'supermodel', :git => 'git://github.com/FOMNick/supermodel'
gem 'rails_config'

# AR Improvements
gem 'squeel'
gem 'meta_search', '>= 1.1.0.pre'
gem 'inherited_resources'
gem 'responders'
gem 'has_scope'
gem 'kaminari'
gem 'uuidtools'
gem 'friendly_id', '~> 4.0.0.beta14' # for sluggable behavior
gem 'enum_simulator', :git => 'git://github.com/FOMNick/enum_simulator.git'
gem 'select_with_include'
gem 'money', :git => 'git://github.com/FOMNick/money.git'

# Templating & View Helpers
gem 'haml'
gem 'jquery-rails'
gem 'formtastic'
gem 'jbuilder'
gem 'gravtastic' # gravatar support
gem 'country_select'
gem 'mail_view'

# Authentication & Permissions
# gem 'authlogic'
gem 'devise'
gem 'cancan'
gem 'bcrypt-ruby', '>= 2.1.4'
gem 'devise_lastseenable', '>= 0.0.3'

# Servers, Workers, Sockets & Push
gem 'foreman'
gem 'thin'
gem 'juggernaut'
gem 'pusher', '= 0.8.5'
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
gem 'ruby_parser'
gem 'timecop'
gem 'traceroute'
gem 'rest-client'


group :development do
    # Debugging & Development
    gem 'ruby-debug19', :require => 'ruby-debug'
    gem 'rails-footnotes', '>= 3.7.5.rc4', :group => :development
    #gem 'query_trace'
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
    #gem 'compass-rails'
    #gem 'extjs-rails-assets'
    gem 'coffee-rails', '~> 3.2.1'
    gem 'uglifier', '>=1.0.3'
    gem 'zurb-foundation'
    gem 'haml_coffee_assets'
end

group :test do
    # Pretty printed test output
    # Note: turn will have to be uninstalled if there are
    # versions > 0.8.2 [lrg]
    gem 'turn', '< 0.8.3'
    gem 'cucumber-rails', '1.2.1'
    gem 'rspec-rails', '2.7.0'
    gem 'database_cleaner', '0.7.1'
    gem 'factory_girl', '2.3.2'
    gem 'minitest'
end
