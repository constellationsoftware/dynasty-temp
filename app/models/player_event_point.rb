class PlayerEventPoint < ActiveRecord::Base
  set_table_name 'dynasty_player_event_points'
  belongs_to :player
  belongs_to :event
end
