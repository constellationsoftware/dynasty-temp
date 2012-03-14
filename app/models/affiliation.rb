class Affiliation < ActiveRecord::Base
    has_one :display_name, :as => :entity
    has_many :affiliation_phases
    has_many :stats,
             :foreign_key => 'membership_id',
             :conditions => ['membership_type = ?', 'affiliations']

    belongs_to :sport
    belongs_to :division
    belongs_to :conference
    has_many :stats, :as => :stat_membership
    has_and_belongs_to_many :documents
    has_many :seasons, :foreign_key => :league_id, :conditions => ['affiliation_type = ?', 'league']
end
