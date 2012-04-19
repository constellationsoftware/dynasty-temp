# == Schema Information
#
# Table name: dynasty_team_favorites
#
#  id         :integer(4)      not null, primary key
#  team_id    :integer(4)
#  player_id  :integer(4)
#  sort_order :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Favorite < ActiveRecord::Base
    self.table_name = 'dynasty_team_favorites'

    belongs_to :team
    belongs_to :player
end
