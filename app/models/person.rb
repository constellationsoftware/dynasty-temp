class Person < ActiveRecord::Base
  #establish_connection(configurations[:sportsdb])
  set_table_name "persons"

  has_one :display_name, :as => :entity
  has_many :person_phases
  has_one :person_score
  has_many :positions, :through => :person_phases
  has_many :stats, :as => :stat_holder
  has_many :person_event_metadatas
  has_many :events, :through => :person_event_metadatas

  has_many(:american_football_defensive_stats,
           :through => :stats,
           :source => :stat_repository,
           :source_type => 'AmericanFootballDefensiveStat'.tableize)
  has_many(:american_football_offensive_stats,
           :through => :stats,
           :source => :stat_repository,
           :source_type => 'AmericanFootballOffensiveStat'.tableize)
  has_many(:american_football_sacks_against_stats,
           :through => :stats,
           :source => :stat_repository,
           :source_type => 'AmericanFootballSacksAgainstStat'.tableize)
  has_many(:american_football_passing_stats,
           :through => :stats,
           :source => :stat_repository,
           :source_type => 'AmericanFootballPassingStat'.tableize)
  has_many(:american_football_rushing_stats,
           :through => :stats,
           :source => :stat_repository,
           :source_type => 'AmericanFootballRushingStat'.tableize)
  has_many(:american_football_scoring_stats,
           :through => :stats,
           :source => :stat_repository,
           :source_type => 'AmericanFootballScoringStat'.tableize)
  has_many(:american_football_fumbles_stats,
           :through => :stats,
           :source => :stat_repository,
           :source_type => 'AmericanFootballFumblesStat'.tableize)
  has_many(:core_stats,
           :through => :stats,
           :source => :stat_repository,
           :source_type => 'CoreStat'.tableize)

  has_many :participants_events, :as => :participant

  has_and_belongs_to_many :documents, :join_table => "persons_documents"
  has_and_belongs_to_many :medias

  has_many :person_scores
  has_one :salary

  has_many :players
  has_many :user_teams, :through => :players

  def current_position
    self.person_phases.current_phase.first
  end

  def current_stats
    self.stats.current.event_stat
  end

  def stat_event_ids
    self.current_stats.map(&:stat_coverage_id)
  end

  def stat_events
    Event.find(self.stat_event_ids)
  end





  #Person.joins(:stats, :american_football_defensive_stats, :american_football_offensive_stats, :american_football_rushing_stats, :stat_repository, :person_phases, :position, :display_name)





end
