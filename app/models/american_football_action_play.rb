# == Schema Information
#
# Table name: american_football_action_plays
#
#  id                               :integer(4)      not null, primary key
#  american_football_event_state_id :integer(4)      not null
#  team_id                          :integer(4)
#  play_type                        :string(100)
#  score_attempt_type               :string(100)
#  touchdown_type                   :string(100)
#  drive_result                     :string(100)
#  points                           :integer(4)
#  comment                          :string(512)
#  recipient_type                   :string(100)
#  penalty_side                     :string(100)
#  penalty_level                    :string(100)
#  penalty_yards                    :integer(4)
#

class AmericanFootballActionPlay < ActiveRecord::Base
    self.table_name = "american_football_action_plays"
    belongs_to :stat, :foreign_key => :stat_repository_id, :conditions => "stat_repository_type='american_football_action_plays'"
    has_many :american_football_action_participants
    belongs_to :team, :class_name => 'SportsDb::Team'
end
