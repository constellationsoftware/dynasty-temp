# == Schema Information
#
# Table name: event_action_fouls
#
#  id             :integer(4)      not null, primary key
#  event_state_id :integer(4)      not null
#  foul_name      :string(100)
#  foul_result    :string(100)
#  foul_type      :string(100)
#  fouler_id      :string(100)
#  recipient_type :string(100)
#  recipient_id   :integer(4)
#  comment        :string(512)
#

class EventActionFoul < ActiveRecord::Base
end
