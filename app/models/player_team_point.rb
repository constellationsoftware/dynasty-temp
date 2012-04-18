class PlayerTeamPoint < ActiveRecord::Base
    self.table_name = 'dynasty_player_team_points'

    belongs_to      :team
    belongs_to      :game
    belongs_to      :lineup
    belongs_to      :score, :class_name => 'PlayerEventPoint', :foreign_key => 'player_point_id'
    has_one         :event, :through => :score
    has_one         :player, :through => :score

    scope :by_team, lambda{ |tid| where{ team_id == my{ tid } } }
    scope :by_game, lambda{ |gid| where{ game_id == my{ gid } } }
end
