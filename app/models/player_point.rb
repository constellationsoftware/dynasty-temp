class PlayerPoint < ActiveRecord::Base
    self.table_name 'dynasty_player_points'
    belongs_to :player
end
