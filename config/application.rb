require File.expand_path('../boot', __FILE__)

require 'rails/all'
#require 'rails-extjs-direct'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(:default, :assets, Rails.env)
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

require 'friendly_id'



module Dynasty
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    config.active_record.observers = :league_observer,
        :user_team_observer,
        :draft_observer,
        :pick_observer #, :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true
    config.serve_static_assets = true
    config.assets.compile = false

    # Compass integration
    # config.sass.load_paths << Compass::Frameworks['compass'].stylesheets_directory
    # config.sass.load_paths << Compass::Frameworks['twitter_bootstrap'].stylesheets_directory

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Disable asset initialization on precompile for heroku deployment w/ devise authentication
    config.assets.initialize_on_precompile = false

    # set up a custom provider for the direct RPC root URL
    #config.middleware.use Rails::ExtJS::Direct::RemotingProvider, "/direct"

    config.active_record.default_timezone = :utc

    config.generators do |g|
        g.template_engine :haml
    
    end
  end
end

module Kernel
  def print_stacktrace
    raise
  rescue
      puts $!.backtrace[1..-1].join("\n")
  end
end




#
# After thin boots, run this shit
#
EM.next_tick do
    # cause the job to be instantiated and therefore queued
    Pusher::Job.instance
end

#
# Mailgun REST client
#



