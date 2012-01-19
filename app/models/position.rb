class Position < ActiveRecord::Base
    include EnumSimulator

    set_table_name 'dynasty_positions'

    has_many :player_positions
    has_many :players,
             :through => :player_positions,
             :class_name => 'Person'

    enum :designation, [:o, :d]
end
