# Be sure to restart your server when you modify this file.
domain_config_options = {
    :key => '_dynasty_session',
    :domain => :all
    #:domain => ".`dynastyowner.net"#, :tld_length => 2
}

# if external override is available, merge in the options
DOMAIN_CONFIG_FILE_PATH = File.join Rails.root, 'config', 'domain.yml'
if FileTest.exists? DOMAIN_CONFIG_FILE_PATH
    data = YAML.load_file(DOMAIN_CONFIG_FILE_PATH)
    overrides = data[::Rails.env] if data
    domain_config_options = domain_config_options.merge! overrides.symbolize_keys! unless overrides.nil?
end
Dynasty::Application.config.session_store :cookie_store, domain_config_options

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
#Dynasty::Application.config.session_store :active_record_store, :domain => :all
