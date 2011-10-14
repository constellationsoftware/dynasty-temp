class SubSeason < ActiveRecord::Base
  has_many :stats, :as => :stat_coverage
  belongs_to :season
end
