class SportsDb::Position < ActiveRecord::Base
    has_many :person_phases, :foreign_key => "regular_position_id"
    has_many :persons, :through => :person_phases
    belongs_to :affiliation
end
