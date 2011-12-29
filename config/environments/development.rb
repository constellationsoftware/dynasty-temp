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
  config.assets.enabled = true
  config.serve_static_assets = true
  config.assets.compile = true

  #Iron Worker to run jobs

  ENV['SIMPLE_WORKER_TOKEN'] = 'H-6n-pFsiR4RFiwJFPnhXW7E8WI'
  ENV['SIMPLE_WORKER_PROJECT_ID'] = '4eebc865066bce1a4e0007a0'

  # Devise action mailer config
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  #ENV['MAILGUN_API_KEY']  = 'key-8po38nxi-4-g6p8tx1zem4lnxzwlgh61'
  #ENV['MAILGUN_API_URL']  = "https://api:key-8po38nxi-4-g6p8tx1zem4lnxzwlgh61@api.mailgun.net/v2/mailgun.net"
  # Example message format
  # RestClient.post MAILGUN_API_URL+"/messages",
  #                :from => "ev@example.com",
  #                :to => "ev@mailgun.net",
  #                :subject => "This is subject",
  #                :text => "Text body",
  #                :html => "<b>HTML</b> version of the body!"
  #
end

require 'pusher'
Pusher.app_id = '10193'
Pusher.key    = '64db7a76d407adc40ff3'
Pusher.secret = 'cf5b7ef9fae37eefa146'


