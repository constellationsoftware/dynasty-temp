# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
# Newrelic Dev mode
# require 'new_relic/rack/developer_mode'
# use NewRelic::Rack::DeveloperMode
require 'sass/plugin/rack'

use Sass::Plugin::Rack
Sass::Plugin.options[:never_update] = true

run Dynasty::Application
