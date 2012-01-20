# Be sure to restart your server when you modify this file.

#Dynasty::Application.config.session_store :cookie_store, :key => '_dynasty_session', :domain => :all#, :tld_length => 2

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
 Dynasty::Application.config.session_store :active_record_store#, :key => '_dynasty_session', :domain => :all#, :tld_length => 2
