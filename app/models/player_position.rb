# == Schema Information
#
# Table name: dynasty_player_positions
#
#  player_id   :integer(4)
#  position_id :integer(4)
#

class PlayerPosition < ActiveRecord::Base
    self.table_name = 'dynasty_player_positions'

    belongs_to :player
    belongs_to :position
end
