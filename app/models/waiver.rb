class Waiver < ActiveRecord::Base
    self.table_name = 'dynasty_waivers'

    belongs_to :player_team
    belongs_to :team
end
