class SubSeason < ActiveRecord::Base
    has_many :stats,
             :source => 'stat_coverage',
             :conditions => ['stat_coverage_type = ?', 'sub_seasons']
    belongs_to :season
    has_many :events
end
