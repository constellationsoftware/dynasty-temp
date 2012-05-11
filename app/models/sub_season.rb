# == Schema Information
#
# Table name: sub_seasons
#
#  id              :integer(4)      not null, primary key
#  sub_season_key  :string(100)     not null
#  season_id       :integer(4)      not null
#  sub_season_type :string(100)     not null
#  start_date_time :datetime
#  end_date_time   :datetime
#

class SubSeason < ActiveRecord::Base
    has_many :stats,
             :source => 'stat_coverage',
             :conditions => ['stat_coverage_type = ?', 'sub_seasons']
    belongs_to :season, :class_name => 'SportsDb::Season'
    has_many :events
end
