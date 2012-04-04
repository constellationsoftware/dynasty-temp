class Media < ActiveRecord::Base
    has_and_belongs_to_many :events
    has_and_belongs_to_many :persons
    has_and_belongs_to_many :teams, :class_name => 'SportsDb::Team'
end
