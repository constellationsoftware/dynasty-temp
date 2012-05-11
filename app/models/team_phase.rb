# == Schema Information
#
# Table name: team_phases
#
#  id              :integer(4)      not null, primary key
#  team_id         :integer(4)      not null
#  start_season_id :integer(4)
#  end_season_id   :integer(4)
#  affiliation_id  :integer(4)      not null
#  start_date_time :string(100)
#  end_date_time   :string(100)
#  phase_status    :string(40)
#  role_id         :integer(4)
#

class TeamPhase < ActiveRecord::Base
    belongs_to :team, :class_name => 'SportsDb::Team'
    belongs_to :affiliation
    belongs_to :start_season, :class_name => 'SportsDb::Season', :foreign_key => :end_season_id
    belongs_to :end_season, :class_name => 'SportsDb::Season', :foreign_key => :start_season_id
    belongs_to :role
end
