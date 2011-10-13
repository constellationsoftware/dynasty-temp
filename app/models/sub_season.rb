class SubSeason < ActiveRecord::Base
  has_polymorphic_as_table
  has_many :stats, :as => :stat_coverage
  belongs_to :season
end
