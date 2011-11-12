require 'active_record'
$config = YAML.load_file(Rails.root + 'config' + 'database.yml')

class AbstractPlayerData < ActiveRecord::Base
	self.abstract_class = true

	establish_connection XEROUND_DATABASE_URL
end