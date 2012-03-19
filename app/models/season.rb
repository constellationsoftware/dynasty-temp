class Season < ActiveRecord::Base
    self.table_name = 'dynasty_seasons'

    def self.current(affiliate = 'nfl')
        season = self.where{ (affiliation == my{ affiliate }) & (current == 1) }.first
        raise "No current season found for affiliation: #{affiliate}." unless season
        season
    end
end
