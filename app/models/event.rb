class Event < ActiveRecord::Base
    default_scope :order => 'start_date_time ASC'
    #default_scope where('start_date_time <= ?', Time.now)

    # TODO: Associated participating players to lock for trading and score calculations
    belongs_to :site
    has_and_belongs_to_many :documents, :join_table => "events_documents"
    has_and_belongs_to_many :medias
    has_many :stats, :as => :stat_coverage
    has_many :participants_events
    has_one :sub_season, :class_name => 'EventSubSeason'
    has_one :season, :through => :sub_season
    has_many :player_points, :class_name => 'PlayerEventPoint'
    has_many :players, :through => :player_points

    def summary
        puts self.start_date_time

        participants = self.participants_events.where { participant_type == 'Team' }
        participants.each do |p|
            puts Team.find(p.participant_id).display_name.full_name
            puts p.score
            puts p.event_outcome
            puts p.alignment
        end
    end

    #Chrono Methods

    def gameday
        self.start_date_time.to_date
    end

    def week
        self.start_date_time.week
    end

    def self.has_date
        Event.start
    end

    def self.past
        where('start_date_time <= ?', Clock.first.time)
    end

    def self.future
        where('start_date_time >= ?', Clock.first.time)
    end

    scope :past_event, self.past
    scope :future_event, self.future


    def teams
        self.participants_events.where { participant_type == 'Team' }
    end

    def home_team
        @team = self.teams.where { alignment == 'home' }.map(&:participant_id)
        Team.find(@team).first
    end

    def away_team
        @team = self.teams.where { alignment == 'away' }.map(&:participant_id)
        Team.find(@team).first
    end

    def winner
        @team = self.teams.where { event_outcome == 'win' }.map(&:participant_id)
        Team.find(@team).first
    end

    def loser
        @team = self.teams.where { event_outcome == 'loss' }.map(&:participant_id)
        Team.find(@team).first
    end


    def self.first_week
        where(week == 1)
    end


    # Need this for the moment because the events table is missing some valid participants
    def self.winners
        @winners = ParticipantsEvent.winner.map(&:event_id)
        Event.find(@winners)
    end

    # needs cleaned up, not very DRY
    # @param person [Object]
    # @param req_stat [Object]
    def event_passing_stats(person)

        self.stats.passing_stat.where("stat_holder_id = ?", person).first
    end

    def event_rushing_stats(person)
        self.stats.rushing_stat.where("stat_holder_id = ?", person).first
    end

    def event_defensive_stats(person)
        @stat = self.stats.defensive_stat.where("stat_holder_id = ?", person).first
    end

    def event_fumbles_stats(person)
        self.stats.fumbles_stat.where("stat_holder_id = ?", person).first
    end

    def event_sacks_stats(person)
        self.stats.sacks_against_stat.where("stat_holder_id = ?", person).first
    end

    def event_scoring_stats(person)
        self.stats.scoring_stat.where("stat_holder_id = ?", person).first
    end

    def event_special_teams_stats(person)
        self.stats.special_teams_stat.where("stat_holder_id = ?", person).first
    end


    #scope :winners, winners
end
