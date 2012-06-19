# == Schema Information
#
# Table name: dynasty_leagues
#
#  id                    :integer(4)      not null, primary key
#  created_at            :datetime
#  updated_at            :datetime
#  default_balance_cents :integer(8)      default(0), not null
#  public                :boolean(1)      default(TRUE)
#  teams_count           :integer(4)
#  balance_cents         :integer(8)      default(0)
#

class League < ActiveRecord::Base
    resourcify
    self.table_name = 'dynasty_leagues'

    money :balance, :cents => :balance_cents

    # TODO: Create views, access control for users, associate league standings, schedules, and trades for teams

    has_many :teams
    has_many :users, :through => :teams
    has_one  :draft
    #has_many :drafts
    has_many :players, :through => :teams
    has_many :player_teams, :through => :teams
    has_many :games
    has_many :payments, :as => :receivable
    has_many :receipts, :as => :payable

    #validates :teams, :length => { :maximum => Settings.league.capacity }
    validates_inclusion_of :tier, :in => [ 'all-pro', 'legend' ]

    scope :with_teams, joins{ teams }.includes{ teams }

    accepts_nested_attributes_for :draft
    attr_accessible :name, :public, :tier, :draft_attributes

    def is_public?; self.public === true end
    def is_private?; !(is_public?) end
end
