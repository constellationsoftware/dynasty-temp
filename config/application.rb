require File.expand_path('../boot', __FILE__)

require 'rails/all'


#require 'rails-extjs-direct'
if defined?(Bundler)
    Bundler.require *Rails.groups(:assets => %w(development integration))
    #Bundler.require(:default, :assets, Rails.env)
end

module Dynasty
    class Application < Rails::Application
        # Settings in config/environments/* take precedence over those specified here.
        # Application configuration should go into files in config/initializers
        # -- all .rb files in that directory are automatically loaded.

        # Custom directories with classes and modules you want to be autoloadable.
        # config.autoload_paths += %W(#{config.root}/extras)
        config.autoload_paths += %W[
            #{Rails.root}/lib
            #{Rails.root}/lib/**/
            #{Rails.root}/app/models/**/
        ]



        # Only load the plugins named here, in the order given (default is alphabetical).
        # :all can be used as a placeholder for all plugins not explicitly named.
        # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

        # Activate observers that should always be running.
        config.active_record.observers = :clock_observer,
            :player_team_observer,
            :account_observer,
            :league_observer,
            :user_observer,
            :team_observer,
            :trade_observer,
            :draft_observer,
            :pick_observer #, :cacher, :garbage_collector, :forum_observer, :juggernaut_observer


        # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
        # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
        #config.time_zone = 'Eastern Time (US & Canada)'

        # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
        # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
        # config.i18n.default_locale = :de

        # Configure the default encoding used in templates for Ruby 1.9.
        config.encoding = "utf-8"

        # Configure sensitive parameters which will be filtered from the log file.
        config.filter_parameters += [:password]

        config.assets.enabled = true

        config.assets.paths << Rails.root.join('vendor', 'assets', 'javascripts', 'extjs', 'default', 'images')
        config.assets.paths << Rails.root.join('vendor', 'assets', 'javascripts', 'extjs', 'stylesheets')
        config.assets.paths << Rails.root.join('vendor', 'assets', 'javascripts', 'extjs', 'javascripts')

        # Set up our ExtJS SASS build environment
        config.sass.load_paths << "#{Rails.root}/vendor/assets/javascripts/extjs/resources/sass"

        config.assets.precompile = ['application.js', 'application.css', 'all-ie.css']
        # Compass integration
        # config.sass.load_paths << Compass::Frameworks['compass'].stylesheets_directory
        # config.sass.load_paths << Compass::Frameworks['twitter_bootstrap'].stylesheets_directory

        # Enable IdentityMap for Active Record
        # to disable set to false or remove the line below.
        config.active_record.identity_map = true
        #ActiveRecord::IdentityMap.enabled = true

        # Version of your assets, change this if you want to expire all your assets
        config.assets.version = '1.3'

        # Disable asset initialization on precompile for heroku deployment w/ devise authentication
        #config.assets.initialize_on_precompile = true

        # set up a custom provider for the direct RPC root URL
        #config.middleware.use Rails::ExtJS::Direct::RemotingProvider, "/direct"

        config.active_record.default_timezone = :utc

        config.generators do |g|
            g.template_engine :haml
        end

        ##
        # Actionmailer config including Mailgun settings
        #
        $MAILGUN_API_KEY = 'key-8po38nxi-4-g6p8tx1zem4lnxzwlgh61'
=begin
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.perform_deliveries = true
        config.action_mailer.raise_delivery_errors = true
        config.action_mailer.smtp_settings = {
             :authentication => :plain,
             :address => 'smtp.mailgun.org',
             :port => 465,
             :domain => 'dynastyowner.mailgun.org',
             :user_name => 'postmaster',
             :password => '86kuzjspp1u4',
             :enable_starttls_auto => true
        }
=end
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = {
            :address              => 'smtp.gmail.com',
            :port                 => 587,
            :domain               => 'baci.lindsaar.net',
            :user_name            => 'nick@frontofficemedia.com',
            :password             => 'frontoffice556',
            :authentication       => 'plain',
            :enable_starttls_auto => true
        }
        #config.action_mailer.default_url_options = { :host => config.domain }
        #config.action_mailer.asset_host = "http://" + config.domain

        # prevent ActionController from calling helpers :all
        config.action_controller.include_all_helpers = false
        #config.action_controller.asset_host = "http://assets.dynastyowner.local"

        # Newrelic Garbace Collection Stats
        GC::Profiler.enable

        config.generators do |g|
            g.test_framework      :rspec, :fixture => true
            g.fixture_replacement :fabrication
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
