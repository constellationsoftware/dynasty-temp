class AbstractPlayerData < ActiveRecord::Base
	self.abstract_class = true
	establish_connection 'player_data'
end
