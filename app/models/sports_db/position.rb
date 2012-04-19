# == Schema Information
#
# Table name: dynasty_positions
#
#  id               :integer(4)      not null, primary key
#  name             :string(32)
#  abbreviation     :string(5)
#  designation      :string(1)       not null
#  sort_order       :integer(4)
#  flex_position_id :integer(4)
#

class SportsDb::Position < ActiveRecord::Base
    has_many :person_phases, :foreign_key => "regular_position_id"
    has_many :persons, :through => :person_phases
    belongs_to :affiliation
end
