# == Schema Information
#
# Table name: dynasty_seasons
#
#  id          :integer(4)      not null, primary key
#  affiliation :string(6)       not null
#  year        :integer(4)      not null
#  weeks       :integer(4)      default(0), not null
#  current     :boolean(1)      default(FALSE), not null
#  start_date  :date            not null
#  end_date    :date
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

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
