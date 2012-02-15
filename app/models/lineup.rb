class Lineup < ActiveRecord::Base
    self.table_name = 'dynasty_lineups'

    belongs_to :position
end
