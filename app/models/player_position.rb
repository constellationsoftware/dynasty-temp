class PlayerPosition < ActiveRecord::Base
    self.table_name = 'dynasty_player_positions'

    belongs_to :player
    belongs_to :position
end
