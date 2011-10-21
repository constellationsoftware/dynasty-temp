class TeamPhase < ActiveRecord::Base
  belongs_to :team
  belongs_to :affiliation
  belongs_to :season, :foreign_key => :end_season_id
  belongs_to :season, :foreign_key => :start_season_id
  belongs_to :role
end
