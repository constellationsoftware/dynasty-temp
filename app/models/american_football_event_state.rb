# == Schema Information
#
# Table name: american_football_event_states
#
#  id                    :integer(4)      not null, primary key
#  event_id              :integer(4)      not null
#  current_state         :integer(2)
#  sequence_number       :integer(4)
#  period_value          :integer(4)
#  period_time_elapsed   :string(100)
#  period_time_remaining :string(100)
#  clock_state           :string(100)
#  down                  :integer(4)
#  team_in_possession_id :integer(4)
#  score_team            :integer(4)
#  score_team_opposing   :integer(4)
#  distance_for_1st_down :integer(4)
#  field_side            :string(100)
#  field_line            :integer(4)
#  context               :string(40)
#  score_team_away       :integer(4)
#  score_team_home       :integer(4)
#  document_id           :integer(4)
#

class AmericanFootballEventState < ActiveRecord::Base
    belongs_to :document
    belongs_to :event
end
