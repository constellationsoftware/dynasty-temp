source 'http://rubygems.org'
source 'http://gems.github.com'

# Core Gems
gem 'rails', '3.2.2'
gem 'mysql2'
gem 'activesupport', '~> 3.2.2'
gem 'execjs'
gem 'therubyracer'
gem 'supermodel', :git => 'git://github.com/FOMNick/supermodel'
gem 'rails_config', :git => 'git://github.com/railsjedi/rails_config.git'
gem 'guard'
gem 'spork-rails'
# PostgreSQL Testing -
#gem 'taps'
#gem 'pg'

# Active Admin
gem 'activeadmin', :git => 'git://github.com/gregbell/active_admin.git'

# Payment Processing

gem 'activemerchant'
gem "authorize-net", "~> 1.5.2"


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
gem 'transitions', :require => [ 'transitions', 'active_model/transitions' ]

# Data Tools
gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
gem 'paper_trail'
gem "active_model_serializers", :git => "git://github.com/josevalim/active_model_serializers.git"
gem 'jbuilder'
gem 'rabl'
gem 'gon'
gem 'yaml_db'
gem 'valium'
gem 'dalli'
gem 'multi_json'
gem 'yajl-ruby'
gem 'oj'


# Templating & View Helpers
gem 'haml'
gem 'haml-rails'
gem 'jquery-rails'
gem 'simple_form'
gem "quantify", "~> 3.1.2"
gem "watu_table_builder", :require => "table_builder", :git => "git://github.com/watu/table_builder.git"

gem 'gravtastic' # gravatar support
gem 'country_select'
gem 'mail_view'

# Pjax PushState
gem 'rack-pjax'
gem "pjax-rails", "~> 0.1.4"

gem 'show_for'

# Authentication & Permissions
# gem 'authlogic'
gem 'devise'
gem 'cancan'
gem 'rolify'
gem 'bcrypt-ruby', '>= 2.1.4'
gem 'devise_lastseenable', '>= 0.0.3'

# Servers, Workers, Sockets & Push
gem 'foreman'
gem 'thin'
gem 'redis'
gem 'redis-objects'
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
gem 'newrelic_rpm'


group :development do
    # Debugging & Development
    gem 'ruby-debug19', :require => 'ruby-debug'
    #gem 'query_trace'
    #gem 'rails-dev-tweaks', '~> 0.6.1'
    gem 'pry-rails'
end

group :production do
#    gem 'pg'
end

group :development, :test do
    gem 'rack'
    gem 'rspec-rails' #, '2.7.0'
    gem 'jasmine'
    gem 'jasminerice'
    gem 'guard-jasmine'
    gem 'guard-rails-assets'
    gem 'guard-bundler'
    gem "rack-livereload"
    gem 'guard-livereload'
    gem 'forgery', '0.5.0'
    gem 'fabrication'
end

gem 'showoff-io'
# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
    gem 'sass-rails', '~> 3.2.3'
    gem 'coffee-rails', '~> 3.2.1'
    gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
    gem 'kickstrap_rails'
    gem 'modernizr-rails'
    #for datatables
    gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
    gem 'jquery-ui-rails'
    gem 'will_paginate'

    gem 'compass-rails'
    #gem 'extjs-rails-assets'

    gem 'uglifier', '>=1.0.3'
    #gem 'zurb-foundation'
    gem 'haml_coffee_assets'
    gem 'i18n-js'
end

group :test do
    # Pretty printed test output
    # Note: turn will have to be uninstalled if there are
    # versions > 0.8.2 [lrg]
    gem 'turn', '< 0.8.3'

    gem 'guard-spork'
    gem 'guard-rspec'
    gem 'cucumber-rails', :require => false #, '1.2.1'
    gem 'database_cleaner', '0.7.1'
    gem 'guard-cucumber'
    gem 'email_spec'
    gem 'factory_girl_rails'
    gem 'rb-fsevent'
    gem 'growl'
    gem 'shoulda'
end
