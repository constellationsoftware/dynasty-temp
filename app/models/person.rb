class Person < ActiveRecord::Base
  set_table_name "persons"

  has_one :display_name, :as => :entity
  has_one :person_phase
  has_one :person_score
  has_many :positions, :through => :person_phases
  has_many :stats, :as => :stat_holder

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

  has_many :participants_events, :as => :participants

  has_and_belongs_to_many :documents, :join_table => :persons_documents
  has_and_belongs_to_many :medias, :join_table => :persons_media

  has_many :person_scores
  has_one :salary

  has_many :user_team_persons
  has_many :user_teams, :through => :user_team_persons

  Person.joins(:stats, :american_football_defensive_stats, :american_football_offensive_stats, :american_football_rushing_stats, :stat_repository, :person_phases, :position, :display_name)


end
