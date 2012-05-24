Dynasty::Application.configure do
    # Settings specified here will take precedence over those in config/application.rb

    # Code is not reloaded between requests
    config.cache_classes = true

    # Full error reports are disabled and caching is turned on
    config.consider_all_requests_local = false # set to true for detailed errors
    config.action_controller.perform_caching = true # set to false for fake dev mode

    # Disable Rails's static asset server (Apache or nginx will already do this)
    config.serve_static_assets = false

    # Compress JavaScripts and CSS
    config.assets.compress = true

    # Don't fallback to assets pipeline if a precompiled asset is missed
    config.assets.compile = false

    # Generate digests for assets URLs
    config.assets.digest = true

    # TODO: Set up a CDN for assets.
    #config.action_controller.asset_host = "http://dynastyowner.local/"

    # Only use best-standards-support built into browsers
    #config.action_dispatch.best_standards_support = :builtin




    config.assets.debug = true
    #config.assets.css_compressor = :yui
    #config.assets.js_compressor = :uglifier
    config.assets.digest = true
    config.assets.initialize_on_precompile = true

    # load assets from a different domain
    config.action_controller.asset_host = "http://assets.dynastyowner.local"
    #config.assets.prefix = '/'
    # Precompile *all* assets, except those that start with underscore
    #config.assets.precompile << /(^[^_\/]|\/[^_])[^\/]*$/


    # Defaults to Rails.root.join("public/assets")
    # config.assets.manifest = YOUR_PATH

    # Specifies the header that your server uses for sending files
    # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
    config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

    # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
    # config.force_ssl = true

    # See everything in the log (default is :info)
    config.log_level = :info
    config.logger = Logger.new(Rails.root.join("log", Rails.env + ".log"), 3, 5*1024*1024)

    # Use a different logger for distributed setups
    # config.logger = SyslogLogger.new

    # Raise exception on mass assignment protection for Active Record models
    config.active_record.mass_assignment_sanitizer = :logger

    # Log the query plan for queries taking more than this (works
    # with SQLite, MySQL, and PostgreSQL)
    config.active_record.auto_explain_threshold_in_seconds = 0.5

    # Use a different cache store in production
    config.cache_store = :dalli_store

    # Note: Current memcached init (accessed by dalli):
    # memcached -d -p 11211 -m 256 -L

    # Enable serving of images, stylesheets, and JavaScripts from an asset server
    # config.action_controller.asset_host = "http://assets.example.com"

    # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
    # config.assets.precompile += %w( search.js )

    # Disable delivery errors, bad email addresses will be ignored
    # config.action_mailer.raise_delivery_errors = false

    # Enable threaded mode
    #config.threadsafe!

    # Devise action mailer config
    config.action_mailer.default_url_options = { :host => 'localhost:3000' }

    # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
    # the I18n.default_locale when a translation can not be found)
    config.i18n.fallbacks = true

    # Send deprecation notices to registered listeners
    config.active_support.deprecation = :notify

    # load the banking configuration settings
    Settings.add_source! File.join(Rails.root, 'config', 'settings_banking.yml')
    Settings.reload!

end

