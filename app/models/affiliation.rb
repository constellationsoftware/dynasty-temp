# == Schema Information
#
# Table name: affiliations
#
#  id               :integer(4)      not null
#  affiliation_key  :string(100)     not null, primary key
#  affiliation_type :string(100)
#  publisher_id     :integer(4)      not null
#

class Affiliation < ActiveRecord::Base
    set_primary_key :affiliation_key
    has_one :display_name, :as => :entity
    has_many :affiliation_phases
    has_many :stats,
             :foreign_key => 'membership_id',
             :conditions => ['membership_type = ?', 'affiliations']

    has_many :leagues, :class_name => 'Affiliation::League'
    has_many :sports, :class_name => 'Affiliation::Sport'

    has_many :stats, :as => :stat_membership
    has_and_belongs_to_many :documents

    has_many :seasons, :class_name => 'SportsDb::Season', :foreign_key => :league_id, :conditions => ['affiliation_type = ?', 'league']







    class Affiliation::Sport < Affiliation

    end



    class Affiliation::League < Affiliation
      has_many :teams, :as => :league

      def self.nfl
        where('affiliation_key = ?', 'l.nfl.com')
      end
    end

end
