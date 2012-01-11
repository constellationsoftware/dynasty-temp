class AmericanFootballActionParticipant < ActiveRecord::Base
    belongs_to :stat, :foreign_key => :stat_repository_id, :conditions => "stat_repository_type='american_football_action_participants'"
    belongs_to :american_football_action_play
    belongs_to :person
end
