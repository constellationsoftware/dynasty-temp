class Affiliation < ActiveRecord::Base
  has_one :display_name, :as => :entity
  has_many :affiliation_phases
  belongs_to :sport
  belongs_to :division
  belongs_to :conference
  has_many :stats, :as => :stat_membership
  has_and_belongs_to_many :documents

  Affiliation.joins(:display_name)


end
