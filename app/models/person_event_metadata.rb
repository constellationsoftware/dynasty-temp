class PersonEventMetadata < ActiveRecord::Base
    belongs_to :event
    belongs_to :person
    belongs_to :position
    belongs_to :role
    belongs_to :team, :class_name => 'SportsDb::Team'
end
