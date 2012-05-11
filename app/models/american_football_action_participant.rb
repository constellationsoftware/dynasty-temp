# == Schema Information
#
# Table name: american_football_action_participants
#
#  id                               :integer(4)      not null, primary key
#  american_football_action_play_id :integer(4)      not null
#  person_id                        :integer(4)      not null
#  participant_role                 :string(100)     not null
#  score_type                       :string(100)
#  field_line                       :integer(4)
#  yardage                          :integer(4)
#  score_credit                     :integer(4)
#  yards_gained                     :integer(4)
#

class AmericanFootballActionParticipant < ActiveRecord::Base
    belongs_to :stat, :foreign_key => :stat_repository_id, :conditions => "stat_repository_type='american_football_action_participants'"
    belongs_to :american_football_action_play
    belongs_to :person
end
