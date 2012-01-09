class Schedule < ActiveRecord::Base
  set_table_name 'dynasty_user_team_schedules'
  belongs_to :user_team, :inverse_of => :schedules, :foreign_key => 'team_id', :class_name => 'UserTeam'
  belongs_to :opponent, :class_name => 'UserTeam', :foreign_key => 'opponent_id'

  default_scope :order => 'week ASC'
end
