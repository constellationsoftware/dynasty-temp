# Rails.root/config.ru
require File.expand_path('../config/environment', __FILE__)
require 'sass/plugin/rack'
use Sass::Plugin::Rack
#use Rack::Pjax
run Dynasty::Application

# load the banking configuration settings
Settings.add_source! File.join(Rails.root, 'config', 'settings_banking.yml')
Settings.reload!

