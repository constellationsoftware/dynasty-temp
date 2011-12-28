Dynasty::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Enable the asset pipeline
  config.assets.enabled = false
  config.serve_static_assets = false
  config.assets.compile = false

  # Devise action mailer config
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
end

require 'pusher'
Pusher.app_id = '10193'
Pusher.key    = '64db7a76d407adc40ff3'
Pusher.secret = 'cf5b7ef9fae37eefa146'
