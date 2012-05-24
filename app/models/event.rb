# == Schema Information
#
# Table name: events
#
#  id                    :integer(4)      not null, primary key
#  event_key             :string(100)     not null
#  publisher_id          :integer(4)      not null
#  start_date_time       :datetime
#  site_id               :integer(4)
#  site_alignment        :string(100)
#  event_status          :string(100)
#  duration              :string(100)
#  attendance            :string(100)
#  last_update           :datetime
#  event_number          :string(32)
#  round_number          :string(32)
#  time_certainty        :string(100)
#  broadcast_listing     :string(255)
#  start_date_time_local :datetime
#  medal_event           :string(100)
#  series_index          :string(40)
#

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
    has_one :season, :class_name => 'SportsDb::Season', :through => :sub_season
    has_many :player_points, :class_name => 'PlayerEventPoint'
    has_many :players, :through => :player_points

    def summary
        participants = self.participants_events.where { participant_type == 'Team' }
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
        #where('start_date_time <= ?', Clock.first.time)
    end

    def self.future
        #where('start_date_time >= ?', Clock.first.time)
    end

    scope :past_event, self.past
    scope :future_event, self.future


    def teams
        self.participants_events.where { participant_type == 'Team' }
    end



    def home_team

        SportsDb::Team.find(self.participants_events.home.first.participant_id)
    end

    def away_team
      SportsDb::Team.find(self.participants_events.away.first.participant_id)
    end

    def opponent(player)
      self.home_team unless self.home_team == player.real_team
      self.away_team unless self.away_team == player.real_team
    end

    def winner
        @team = self.teams.where { event_outcome == 'win' }.map(&:participant_id)
        SportsDb::Team.find(@team).first
    end

    def loser
        @team = self.teams.where { event_outcome == 'loss' }.map(&:participant_id)
        SportsDb::Team.find(@team).first
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
