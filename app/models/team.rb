# == Schema Information
#
# Table name: dynasty_teams
#
#  id             :integer(4)      not null, primary key
#  league_id      :integer(4)
#  name           :string(50)      not null
#  user_id        :integer(4)      not null
#  is_online      :boolean(1)      default(FALSE), not null
#  uuid           :binary(255)
#  last_socket_id :string(255)
#  balance_cents  :integer(8)      default(0), not null
#  autopick       :boolean(1)      default(FALSE)
#  waiver_order   :integer(4)
#  draft_order    :integer(4)
#

class Team < ActiveRecord::Base
  resourcify
    self.table_name = 'dynasty_teams'
    money :balance, :cents => :balance_cents

    belongs_to :user
    belongs_to :league, :inverse_of => :teams, :counter_cache => true
    has_many :favorites
    has_many :picks
    has_many :player_teams
    has_many :players, :through => :player_teams
    #has_many :player_team_snapshots
    has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id', :order => :date
    has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id', :order => :date
    has_many :accounts, :as => :receivable
    has_many :accounts, :as => :payable

    scope :online, where(:is_online => true)
    scope :offline, where(:is_online => false)
    scope :with_players, joins{ players }.includes{ players }
    scope :with_games, joins{[ :home_games, :away_games ]}.includes{[ :home_games, :away_games ]}

    #attr_accessor :player_teams



    def payments
      Account.where(:payable_id => self.id).all
    end

    def receipts
      Account.where(:receivable_id => self.id).all
    end

    def all_accounts
      accounts = self.payments + self.receipts
      accounts.sort! { |a, b|  a.transaction_datetime <=> b.transaction_datetime }

    end

    # home and away games ordered by week by default
    def games
        #(self.home_games + self.away_games).sort{ |a, b| a.send(order.to_s) <=> b.send(order.to_s) }
        Game.by_team(id).order{ date }
    end

    def salary_total
        Team.joins{ picks.player.contract }
            .select{ coalesce(sum(picks.player.contract.amount), 0).as('total') }
            .where{ id == my { self.id } }.first.total.to_f
    end

    def is_offline
        self.offline
    end

    def record
        record = self.games.collect do |game|
            outcome = self.won? game
            break if outcome.nil?
            outcome ? 1 : 0
        end
        record || []
    end

    def won?(game); game.won?(self) end
    def lost?(game); !won?(game) end

    # use uuid as a string
    def uuid
        uuid = self.read_attribute(:uuid)
        UUIDTools::UUID.parse_raw(uuid).to_s unless uuid.nil?
    end

    def self.find_by_uuid(uuid_s)
        super UUIDTools::UUID.parse(uuid_s).raw
    end
end
