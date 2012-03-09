class Favorite < ActiveRecord::Base
    self.table_name = 'dynasty_team_favorites'

    belongs_to :team, :class_name => 'UserTeam', :foreign_key => :team_id
    belongs_to :player
end
