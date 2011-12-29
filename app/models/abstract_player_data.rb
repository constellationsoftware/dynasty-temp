class AbstractPlayerData < ActiveRecord::Base
	self.abstract_class = true
  # I think this is a good idea but want to get the heroku deployment process simplified for the moment.
	#establish_connection 'player_data'
end
