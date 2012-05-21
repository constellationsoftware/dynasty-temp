# Rails.root/config.ru
require File.expand_path('../config/environment', __FILE__)
require 'newrelic_rpm'
require 'new_relic/rack/developer_mode'
require 'sass/plugin/rack'
use NewRelic::Rack::DeveloperMode
use Sass::Plugin::Rack
#use Rack::Pjax
run Dynasty::Application

# load the banking configuration settings
Settings.add_source! File.join(Rails.root, 'config', 'settings_banking.yml')
Settings.reload!

