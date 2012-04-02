class UserTeam < ActiveRecord::Base
    self.table_name = 'dynasty_teams'
    money :balance, :cents => :balance_cents

    belongs_to :user
    belongs_to :league, :inverse_of => :teams, :counter_cache => true
    has_many :favorites
    has_many :picks, :foreign_key => 'team_id'
    has_many :player_team_records, :conditions => 'current = TRUE'
    has_many :player_teams,
        :class_name => 'PlayerTeamRecord',
        :conditions => 'current = TRUE'
    has_many :player_team_snapshots
    has_many :players, :through => :player_team_records
    has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id', :order => :date
    has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id', :order => :date
    #has_many :games, :finder_sql => proc{ "SELECT * FROM #{Game.table_name} WHERE home_team_id = #{id} OR away_team_id = #{id}" }
    has_many :payments, :as => :receivable
    has_many :receipts, :as => :payable

    scope :online, where(:is_online => true)
    scope :offline, where(:is_online => false)
    scope :with_players, joins{ players }.includes{ players }
    scope :with_games, joins{[ :home_games, :away_games ]}.includes{[ :home_games, :away_games ]}

    # home and away games ordered by week by default
    def games(order = :date)
        (self.home_games + self.away_games).sort{ |a, b| a.send(order.to_s) <=> b.send(order.to_s) }
    end

    def salary_total
        UserTeam.joins{ picks.player.contract }
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
