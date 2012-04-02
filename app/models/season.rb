class Season < ActiveRecord::Base
    self.table_name = 'dynasty_seasons'
    has_many :transactions, :as => :eventable, :class_name => 'Account'

    scope :for_date, lambda { |date| where{ (start_date <= my{ date.to_time }) & (end_date >= my{ date.to_time }) } }

    def self.current(affiliate = 'nfl')
        season = self.where{ (affiliation == my{ affiliate }) & (current == 1) }.first
        raise "No current season found for affiliation: #{affiliate}." unless season
        season
    end
end
