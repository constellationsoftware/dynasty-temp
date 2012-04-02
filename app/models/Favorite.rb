class Favorite < ActiveRecord::Base
    self.table_name = 'dynasty_team_favorites'

    belongs_to :team
    belongs_to :player
end
