class Stat < ActiveRecord::Base

    belongs_to  :person,
                :conditions => ['stat_holder_type = ?', 'persons']
    belongs_to  :team,
                :conditions => ['stat_holder_type = ?', 'teams'],
                :class_name => 'SportsDb::Team'


    #belongs_to :stat_coverage, :polymorphic => true
    belongs_to :event, :foreign_key => :stat_coverage_id, :class_name => "Event"
    belongs_to :stat_membership #, :polymorphic => true
    #belongs_to :stat_repository#, :polymorphic => true

    belongs_to :sub_season,
               :foreign_key => :stat_coverage_id,
               :conditions => ['stat_coverage_type = ?', 'sub_seasons']

    belongs_to :event,
               :foreign_key => :stat_coverage_id,
               :conditions => ['stat_coverage_type = ?', 'events']
    #Stat.joins(:stat_repository).joins(:stat_coverage).joins(:stat_membership)


    def self.event_stat

        where { stat_coverage_type == 'events' } #.includes{[stat_repository, stat_coverage]}

    end


    def self.career_stat
        where { context == 'career' } #.includes{[stat_repository, stat_coverage]}
    end

    def self.subseason_stat
        where { stat_coverage_type == 'sub_seasons' } #.includes{[stat_repository, stat_coverage]}
    end


    def self.last_season
        where { stat_coverage_id == '11' } #includes{[stat_repository, stat_coverage]}
    end

    def self.this_season
        where { stat_coverage_id == '1' } #includes{[stat_repository, stat_coverage]}
    end

    def self.affiliation_stat
        where { stat_membership_type == 'affiliations' } #includes{[stat_repository, stat_coverage]}
    end

    def self.team_stat
        where { stat_membership_type == 'teams' }
    end

    scope :event, event_stat
    scope :subseason, subseason_stat
    scope :affiliation, affiliation_stat

    # @return [Object]
    def coverage_start_date_time
        self.stat_coverage.start_date_time
    end


    #Need to isolate types of stats for display
    def self.passing
        where { stat_repository_type == 'american_football_passing_stats' }.first.andand.stat_repository
    end

    def self.scoring
        where { stat_repository_type == 'american_football_scoring_stats' }.first.andand.stat_repository
    end

    def self.rushing
        where { stat_repository_type == 'american_football_rushing_stats' }.first.andand.stat_repository
    end

    def self.defense
        where { stat_repository_type == 'american_football_defensive_stats' }.first.andand.stat_repository
    end

    def self.fumbles
        where { stat_repository_type == 'american_football_fumbles_stats' }.first.andand.stat_repository
    end

    def self.sacks
        where { stat_repository_type == 'american_football_sacks_against_stats' }.first.andand.stat_repository
    end

    def self.special_teams
        where { stat_repository_type == 'american_football_special_teams_stats' }.first.andand.stat_repository
    end


    def self.gameday_points
        points = 0
        points
    end


    def self.future
        where('start_date_time >= ?', Clock.first.time)
    end


    scope :current, where('start_date_time <= ?', Clock.first.time)
    scope :future, future

    # copy stat start_date_time from event into stat table - shitty but expedient

    def self.copy_start_date_time
        @stats = Stat.event_stat.where(:start_date_time => nil); nil
        @stats.each do |s|
            s.start_date_time = s.coverage_start_date_time
            s.save!
        end; nil
    end

    def stat_repository
        klass = self.stat_repository_type.classify.constantize
        klass.where { id == my { self.stat_repository_id } }.first
    end

    def stat_coverage
        klass = self.stat_coverage_type.classify.constantize
        klass.where { id == my { self.stat_coverage_id } }.first
    end

    def points
        klass = self.stat_repository_type.classify.constantize
        stat = klass.where { id == my { self.stat_repository_id } }.first
        return stat.points if stat.respond_to? 'points'
    end
end
