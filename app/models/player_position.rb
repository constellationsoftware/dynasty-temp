class PlayerPosition < ActiveRecord::Base
  set_table_name 'dynasty_player_positions'

  belongs_to :player
  belongs_to :position
end
