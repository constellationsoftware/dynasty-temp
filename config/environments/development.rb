Dynasty::Application.configure do

    # Rackup the livereload server
    ##config.middleware.insert_before(
    ##    Rack::Lock, Rack::LiveReload,
    ##    :min_delay => 500,
    ##    :max_delay => 10000,
    ##    :port => 35729#,
    ##    #:host => 'dynastyowner.local'
    ##    #:ignore => [ %r{dont/modify\.html$} ]
##
    ##)
    # ruby
    $stdout.sync = true

    # Settings specified here will take precedence over those in config/application.rb

    # In the development environment your application's code is reloaded on
    # every request.  This slows down response time but is perfect for development
    # since you don't have to restart the web server when you make code changes.
    config.cache_classes = false

    # Log error messages when you accidentally call methods on nil.
    config.whiny_nils = true

    # Show full error reports and disable caching
    config.consider_all_requests_local = true
    config.action_controller.perform_caching = false

    # Don't care if the mailer can't send
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = false

    # Print deprecation notices to the Rails logger
    config.active_support.deprecation = :log

    # Only use best-standards-support built into browsers
    config.action_dispatch.best_standards_support = :builtin

    # Enable the asset pipeline
    #config.assets_prefix = "/dev-assets"
    #config.assets.enabled = true

    #config.assets.initialize_on_precompile = true
    config.serve_static_assets = true

    #config.assets.compile = true
    config.assets.compress = false
    #config.assets.css_compressor = :yui
    #config.assets.js_compressor = :uglifier

    # Set to true] x for individual stylesheets
    config.assets.debug = true
    config.assets.logger = nil


    # Raise exception on mass assignment protection for Active Record models
    config.active_record.mass_assignment_sanitizer = :logger

    # Log the query plan for queries taking more than this (works
    # with SQLite, MySQL, and PostgreSQL)
    config.active_record.auto_explain_threshold_in_seconds = 0.5


    # Rotate Log Files. example:
    # config.logger = Logger.new(Rails.root.join("log",Rails.env + ".log"),3,5*1024*1024)
    # will rotate every 5 megabytes, keeping the 3 most recent used logs = 15 mb of logs
    config.log_level = :debug
    config.logger = Logger.new(Rails.root.join("log", Rails.env + ".log"), 3, 5*1024*1024)

    # Devise action mailer config
    config.action_mailer.default_url_options = { :host => 'localhost:5000' }

   # config.after_initialize do
   #     Moonshado::Sms.configure do |config|
   #         config.api_key = 'http://65ecea4bba559b49@heroku.moonshado.com'
   #     end
   # end

     # Example message format
    # RestClient.post MAILGUN_API_URL+"/messages",
    #                :from => "ev@example.com",
    #                :to => "ev@mailgun.net",
    #                :subject => "This is subject",
    #                :text => "Text body",
    #                :html => "<b>HTML</b> version of the body!"
    #

    # load the banking configuration settings
    Settings.add_source! File.join(Rails.root, 'config', 'settings_banking.yml')
    Settings.reload!


end


unless $rails_rake_task
    #require 'ruby-debug'
    #
    #Debugger.settings[:autoeval] = true
    #Debugger.settings[:autolist] = 1
    #Debugger.settings[:reload_source_on_change] = true
    #Debugger.start_remote
end
