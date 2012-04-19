# == Schema Information
#
# Table name: event_action_substitutions
#
#  id                           :integer(4)      not null, primary key
#  event_state_id               :integer(4)      not null
#  person_original_id           :integer(4)      not null
#  person_original_position_id  :integer(4)      not null
#  person_replacing_id          :integer(4)      not null
#  person_replacing_position_id :integer(4)      not null
#  substitution_reason          :string(100)
#  comment                      :string(512)
#

class EventActionSubstitution < ActiveRecord::Base
end
