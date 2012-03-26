class PlayerTeamSnapshot < ActiveRecord::Base
    self.table_name = 'dynasty_player_team_snapshots'

    belongs_to :player
    belongs_to :team, :class_name => 'UserTeam', :foreign_key => :team_id
    has_one :league, :through => :team
    belongs_to :event, :class_name => 'Events::Base', :polymorphic => true, :conditions => { :type => 'Events::PlayerPayroll' }
end
