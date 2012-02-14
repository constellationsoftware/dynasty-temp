class AmericanFootballActionPlay < ActiveRecord::Base
    self.table_name = "american_football_action_plays"
    belongs_to :stat, :foreign_key => :stat_repository_id, :conditions => "stat_repository_type='american_football_action_plays'"
    has_many :american_football_action_participants
    belongs_to :team
end
