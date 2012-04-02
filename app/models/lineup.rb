class Lineup < ActiveRecord::Base
    self.table_name = 'dynasty_lineups'

    belongs_to :position
    has_many :flex_positions,
        :through => :position,
        :conditions => { :flex => true }
    has_many :player_teams, :class_name => 'PlayerTeam', :inverse_of => :lineup
end
