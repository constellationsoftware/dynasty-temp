class Person < ActiveRecord::Base
  set_table_name 'persons'
  
  has_one :display_name,
    :foreign_key => 'entity_id',
    :conditions => [ 'entity_type = ?', 'persons' ]

  has_many :person_phases
  has_many :positions, :through => :person_phases
  has_many :stats,
    :foreign_key => 'stat_holder_id',
    :conditions => [ 'stat_holder_type = ?', 'persons' ]
  has_many :passing_stats,
    :through => :stats,
    :class_name => 'AmericanFootballPassingStat',
    :source => :stat_repository,
    :conditions => [ 'stat_repository_type = ?', 'american_football_passing_stats' ]
  has_many :person_event_metadatas
  has_many :events, :through => :person_event_metadatas

  has_many :participants_events, :as => :participant

  #has_and_belongs_to_many :documents, :join_table => "persons_documents"
  #has_and_belongs_to_many :medias

  #has_one  :person_score
  #has_many :person_scores
  #has_many :players
  #has_many :user_teams, :through => :players

  def self.with_points_from_season(season = 'last')
    joins{[stats, stats.sub_season.season]}.includes{stats}
      .where{stats.sub_season.seasons.season_key == "#{1.year.ago.year}"}
  end


  def current_position
    self.person_phases.current_phase.first
  end

  def current_stats
    self.stats.current.event_stat
  end

  def stat_event_ids
    self.current_stats.map(:stat_coverage_id)
  end

  def stat_events
    Event.find(self.stat_event_ids)
  end
end
