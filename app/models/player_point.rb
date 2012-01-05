class PlayerPoint < ActiveRecord::Base
  set_table_name 'dynasty_player_points'
  belongs_to :player

end
