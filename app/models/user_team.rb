class UserTeam < ActiveRecord::Base
    self.table_name = 'dynasty_teams'

    belongs_to :user
    belongs_to :league
    has_many :user_team_lineups
    has_many :auto_picks
    has_many :picks, :foreign_key => 'team_id'
    has_many :player_team_records, :conditions => 'current = TRUE'
    has_many :player_teams,
        :class_name => 'PlayerTeamRecord',
        :conditions => 'current = TRUE'
    has_many :player_team_histories
    has_many :players, :through => :player_team_records
    money :balance, :cents => :balance_cents

    has_many :games, :foreign_key => 'team_id'
    has_many :schedules, :inverse_of => :team, :foreign_key => 'team_id'
    has_many :opponents, :through => :schedules

    scope :online, where(:is_online => true)
    scope :offline, where(:is_online => false)
    scope :with_players, joins{ players }.includes{ players }
    scope :with_schedule, joins{ schedules }.includes{ schedules }

    def salary_total
        UserTeam.joins { picks.player.contract }.select { coalesce(sum(picks.player.contract.amount), 0).as('total') }.where { id == my { self.id } }.first.total.to_f
    end

    before_create :generate_uuid
    after_create :initial_balance_from_league

    # @return [Object]
    # TODO The initial balance should be set by league settings
    def initial_balance_from_league
        if !!self.league_id
            self.balance = self.league.default_balance
        else
            self.balance = 75000000
        end
        self.save
    end

    def is_offline
        self.offline
    end

    # use uuid as a string
    def uuid
        parse_uuid_to_s
    end

    # convert a uuid to string
    def parse_uuid_to_s
        (self[:uuid].empty?) ? nil : UUIDTools::UUID.parse_raw(self[:uuid]).to_s
    end

    def self.find_by_uuid(uuid_s)
        uuid = UUIDTools::UUID.parse(uuid_s)
        raw = uuid.raw
        super(raw)
    end

    protected
        def generate_uuid
            uuid = UUIDTools::UUID.timestamp_create
            self.uuid = uuid.raw
        end
end
