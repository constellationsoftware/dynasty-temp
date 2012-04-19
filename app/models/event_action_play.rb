# == Schema Information
#
# Table name: event_action_plays
#
#  id                 :integer(4)      not null, primary key
#  event_state_id     :integer(4)      not null
#  play_type          :string(100)
#  score_attempt_type :string(100)
#  play_result        :string(100)
#  comment            :string(512)
#

class EventActionPlay < ActiveRecord::Base
end
