class Team < ActiveRecord::Base
    self.table_name = 'dynasty_teams'
    money :balance, :cents => :balance_cents

    belongs_to :user
    belongs_to :league, :inverse_of => :teams, :counter_cache => true
    has_many :favorites
    has_many :picks
    has_many :player_teams
    has_many :players, :through => :player_teams
    has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id', :order => :date
    has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id', :order => :date
    has_many :payments, :as => :receivable
    has_many :receipts, :as => :payable

    scope :online, where(:is_online => true)
    scope :offline, where(:is_online => false)
    scope :with_players, joins{ players }.includes{ players }
    scope :with_games, joins{[ :home_games, :away_games ]}.includes{[ :home_games, :away_games ]}
    scope :with_picks, joins{ picks }.includes{ picks }

    #attr_accessor :player_teams

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

    def online?; self.is_online end
    def autopicking?; self.autopick end
end
