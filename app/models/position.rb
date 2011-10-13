class Position < ActiveRecord::Base
  has_many :person_phases, :foreign_key => "regular_position_id"
  belongs_to :affiliation
end
