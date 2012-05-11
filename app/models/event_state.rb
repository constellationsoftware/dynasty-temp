# == Schema Information
#
# Table name: event_states
#
#  id                     :integer(4)      not null, primary key
#  event_id               :integer(4)      not null
#  current_state          :integer(4)
#  sequence_number        :integer(4)
#  period_value           :string(100)
#  period_time_elapsed    :string(100)
#  period_time_remaining  :string(100)
#  minutes_elapsed        :string(100)
#  period_minutes_elapsed :string(100)
#  context                :string(40)
#  document_id            :integer(4)
#

class EventState < ActiveRecord::Base
    belongs_to :document
end
