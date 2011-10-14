source 'http://rubygems.org'
source 'http://gems.github.com'

gem 'rails', '3.1.0'
gem 'activesupport', '~> 3.1.0'
gem 'haml'

group :production do
  gem 'pg'
end
group :development, :test do
  gem 'mysql2'
  gem 'rack', '1.3.3'
end


# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'thin'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
