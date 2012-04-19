# == Schema Information
#
# Table name: dynasty_lineups
#
#  id          :integer(4)      not null, primary key
#  position_id :integer(4)
#  flex        :boolean(1)
#  string      :integer(4)
#

class Lineup < ActiveRecord::Base
    self.table_name = 'dynasty_lineups'

    belongs_to :position
    has_many :flex_positions,
        :through => :position,
        :source => :positions
    has_many :player_teams, :inverse_of => :lineup
    has_many :players, :through => :player_teams

    scope :with_positions, joins{[ position, flex_positions.outer ]}
        .includes{[ position, flex_positions.outer ]}
    scope :empty, lambda{ |my_team_id|
        subquery = PlayerTeam.select{ lineup_id }.where{ (team_id == (my_team_id)) & (lineup_id != nil) }
        where{ id << subquery }
    }

    def positions
        self.flex ? self.flex_positions : [ self.position ]
    end
end
