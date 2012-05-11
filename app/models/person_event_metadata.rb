# == Schema Information
#
# Table name: person_event_metadata
#
#  id                   :integer(4)      not null, primary key
#  person_id            :integer(4)      not null
#  event_id             :integer(4)      not null
#  status               :string(100)
#  health               :string(100)
#  weight               :string(100)
#  role_id              :integer(4)
#  position_id          :integer(4)
#  team_id              :integer(4)
#  lineup_slot          :integer(4)
#  lineup_slot_sequence :integer(4)
#

class PersonEventMetadata < ActiveRecord::Base
    belongs_to :event
    belongs_to :person
    belongs_to :position
    belongs_to :role
    belongs_to :team, :class_name => 'SportsDb::Team'
end
