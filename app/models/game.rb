class Game < ActiveRecord::Base
    set_table_name 'dynasty_games'
    belongs_to :team, :class_name => 'UserTeam', :foreign_key => 'team_id'
end
