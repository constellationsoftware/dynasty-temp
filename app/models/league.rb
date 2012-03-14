class League < ActiveRecord::Base
    self.table_name = 'dynasty_leagues'

    extend FriendlyId
    friendly_id :name, :use => :slugged
    money :default_balance, :cents => :default_balance_cents, :precision => 0
    money :balance, :cents => :balance_cents

    #TODO: Create views, access control for users, associate league standings, schedules, and trades for user_teams
    has_many :teams, :class_name => 'UserTeam'
    has_many :users, :through => :teams
    has_many :drafts
    has_many :players, :through => :teams
    has_many :player_team_records, :through => :teams
    has_many :player_team_records
    #  requires :attribute, :name, :size
    belongs_to :manager, :class_name => 'User', :inverse_of => :leagues
    belongs_to :clock, :inverse_of => :leagues
    has_many :payments, :as => :receivable
    has_many :receipts, :as => :payable

    validates_presence_of :name, :size
    validates_uniqueness_of :name
    validates_format_of :name, :with => /^[[:alnum:] ]+$/, :on => :create
    validates_inclusion_of :size, :in => Settings.league.capacity
    validates_length_of :password,
        :minimum => Settings.league.password_min_length,
        :maximum => Settings.league.password_max_length,
        :if => lambda{ |league| league.is_private? }

    scope :with_manager, joins{ manager }.includes{ manager }
    scope :with_teams, joins{ teams }.includes{ teams }
    scope :filter_by_name, lambda{ |league_name|
        where{ name =~ "#{league_name}%" }
    }

    def calculate_game_points
        self.teams.each do |team|
            points = weekly_points_for_team(team)
            Game.create :team_id => team.id, :week => self.week, :points => (points ? points : 0)
        end
    end

    def weekly_points_for_team(team)
        week_end = self.clock.time
        week_start = week_end.advance :weeks => -1

        starter_points = PlayerEventPoint.select{ sum(points).as('points') }
            .joins{[ event, player.team_link.team ]}
            .where{ player.team_link.team.id == my{ team.id } }
            .where{ player.team_link.depth == 1 }
            .where{ (event.start_date_time >= week_start) & (event.start_date_time < week_end) }
            .first.points
        bench_points = PlayerEventPoint.select{ sum(points).as('points') }
            .joins{[ event, player.team_link.team ]}
            .where{ player.team_link.team.id == my{ team.id } }
            .where{ player.team_link.depth == 0 }
            .where{ (event.start_date_time >= week_start) & (event.start_date_time < week_end) }
            .first.points
        starter_points.to_f + (bench_points.to_f / 3)
    end


    # gets the active draft (if any)
    def draft
        self.drafts.first
    end

    def is_public?; self.public === true end
    def is_private?; !(is_public?) end
end
