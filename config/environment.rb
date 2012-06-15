# Load the rails application
require File.expand_path('../application', __FILE__)

# require ActiveMerchant
require 'active_merchant'
# Paperclip
# If this bugs out, symlink the directory below to wherever imagemagick is on your local system
Paperclip.options[:command_path] = "/usr/local/bin/imagemagick"

# Initialize the rails application
Dynasty::Application.initialize!
