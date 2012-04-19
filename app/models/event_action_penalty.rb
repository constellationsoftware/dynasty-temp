# == Schema Information
#
# Table name: event_action_penalties
#
#  id             :integer(4)      not null, primary key
#  event_state_id :integer(4)      not null
#  penalty_type   :string(100)
#  penalty_level  :string(100)
#  caution_level  :string(100)
#  recipient_type :string(100)
#  recipient_id   :integer(4)
#  comment        :string(512)
#

class EventActionPenalty < ActiveRecord::Base
end
