class TeamPhase < ActiveRecord::Base
    belongs_to :team, :class_name => 'SportsDb::Team'
    belongs_to :affiliation
    belongs_to :start_season, :class_name => 'SportsDb::Season', :foreign_key => :end_season_id
    belongs_to :end_season, :class_name => 'SportsDb::Season', :foreign_key => :start_season_id
    belongs_to :role
end
