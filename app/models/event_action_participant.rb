# == Schema Information
#
# Table name: event_action_participants
#
#  id                   :integer(4)      not null, primary key
#  event_state_id       :integer(4)      not null
#  event_action_play_id :integer(4)      not null
#  person_id            :integer(4)      not null
#  participant_role     :string(100)
#

class EventActionParticipant < ActiveRecord::Base
end
