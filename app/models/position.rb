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

class Position < ActiveRecord::Base
    include EnumSimulator

    self.table_name = 'dynasty_positions'

    has_many :player_positions
    has_many :lineups
    has_many :player_teams, :through => :lineups
    belongs_to :flex_position, :class_name => 'Position'
    has_many :positions, :foreign_key => :flex_position_id, :inverse_of => :flex_position
    has_many :players,
             :through => :player_positions,
             :class_name => 'Player'
    has_many :player_teams,
             :through => :players,
             :class_name => 'PlayerTeam'
    enum :designation, [:o, :d]

    scope :offense, where{ designation == :o }
    scope :defense, where{ designation == :d }

    def self.flex_filter(my_designation = nil)
        result = where{ flex == 1 }
        result = result.where{ designation == my{ my_designation.to_s } } unless my_designation.nil?
        result
    end
end
