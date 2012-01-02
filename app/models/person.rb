class Person < ActiveRecord::Base
  set_table_name 'persons'
  has_one :photo
  has_one :display_name,
    :foreign_key => 'entity_id',
    :conditions => [ 'entity_type = ?', 'persons' ]

  has_many :teams, :through => :person_phases

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
  
  has_many :rushing_stats,
    :through => :stats,
    :class_name => 'AmericanFootballRushingStat',
    :source => :stat_repository,
    :conditions => [ 'stat_repository_type = ?', 'american_football_rushing_stats' ]
  
  has_many :defensive_stats,
    :through => :stats,
    :class_name => 'AmericanFootballDefensiveStat',
    :source => :stat_repository,
    :conditions => [ 'stat_repository_type = ?', 'american_football_defensive_stats' ]
  
  has_many :fumbles_stats,
    :through => :stats,
    :class_name => 'AmericanFootballFumblesStat',
    :source => :stat_repository,
    :conditions => [ 'stat_repository_type = ?', 'american_football_fumbles_stats' ]
  
  has_many :sacks_against_stats,
    :through => :stats,
    :class_name => 'AmericanFootballSacksAgainstStat',
    :source => :stat_repository,
    :conditions => [ 'stat_repository_type = ?', 'american_football_sacks_against_stats' ]
  
  has_many :special_teams_stats,
    :through => :stats,
    :class_name => 'AmericanFootballSpecialTeamsStat',
    :source => :stat_repository,
    :conditions => [ 'stat_repository_type = ?', 'american_football_special_teams_stats' ]

  has_many :scoring_stats,
    :through => :stats,
    :class_name => 'AmericanFootballScoringStat',
    :source => :stat_repository,
    :conditions => [ 'stat_repository_type = ?', 'american_football_scoring_stats' ]


  has_many :person_event_metadatas
  has_many :events, :through => :person_event_metadatas

  has_many :participants_events, :as => :participant
  has_one :contract
  has_one :points, :class_name => 'PlayerPoint', :foreign_key => 'player_id'
  #has_and_belongs_to_many :documents, :join_table => "persons_documents"
  #has_and_belongs_to_many :medias

  #has_one  :person_score
  #has_many :person_scores
  #has_many :players
  #has_many :user_teams, :through => :players

  def self.calculate_points_from_season(season)
      joins{[stats, stats.sub_season.season]}.includes{stats}
        .where{stats.sub_season.season.season_key == "#{season}"}
  end

  def self.with_points_from_season(season = 'last')
    if season.is_a? String
      current_year = Season.maximum(:season_key).to_i
      case season
      when 'current'
        return joins{[stats, stats.event.season]}.includes{stats}
          .where{stats.event.season.season_key == "#{current_year}"}
      else # last season
        season = current_year - 1
      end
    end
    joins{points}.where{points.year == "#{season}"}
  end


  def self.current_player
    self.with_points_from_season(season = 'last')
  end

  def current_position
    self.person_phases.current_phase.first
  end

  def current_team
    Team.find(self.current_position.membership_id)
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

  def event_stats
    self.stats.where(:stat_coverage_type => "events")
  end

  def subseason_stats
    self.stats.where(:stat_coverage_type => "sub_seasons")
  end


  ## USE LIKE THIS:
  # @person.game_stats(@person.events.first)
  # @person.game_stats(@person.events.all)
  # @person.game_stats(some_event_id)
  def game_stats(event)
    self.event_stats.where(:stat_coverage_id => event)
  end

  def game_points(event)
    stats = self.event_stats.where(:stat_coverage_id => event)
    p = 0
    p += stats.passing.andand.points ||= 0
    p += stats.rushing.andand.points ||= 0
    p += stats.defense.andand.points ||= 0
    p += stats.fumbles.andand.points ||= 0
    p += stats.sacks.andand.points ||= 0
    p += stats.special_teams.andand.points ||= 0
  end 

  def season_points(season)
    stats = self.subseason_stats.where(:stat_coverage_id => season)
    p = 0
    p += stats.passing.andand.points ||= 0
    p += stats.rushing.andand.points ||= 0
    p += stats.defense.andand.points ||= 0
    p += stats.fumbles.andand.points ||= 0
    p += stats.sacks.andand.points ||= 0
    p += stats.special_teams.andand.points ||= 0
  end 


  def current_season_points(season)
    stats = self.event_stats.current
    p = 0
    p += stats.passing.andand.points ||= 0
    p += stats.rushing.andand.points ||= 0
    p += stats.defense.andand.points ||= 0
    p += stats.fumbles.andand.points ||= 0
    p += stats.sacks.andand.points ||= 0
    p += stats.special_teams.andand.points ||= 0
  end 



  def active
    self.person_phases.current_phase.stat
  end

  #def contract_end_year
  #  self.contract.end_year
  #end

  def get_contract
    @person = self
    # get contract info
          team = @person.current_team.name.gsub! /\s+/, '-'
          name = @person.display_name.full_name.gsub! /\s+/, '-'
          url = "http://www.spotrac.com/nfl/#{team}/#{name}"
          spotrac_doc = Nokogiri::HTML(open(url))
          @contract = spotrac_doc.css("span.playerValue")
          @person.contract.summary = @contract[0].andand.text
          @person.contract.amount = @contract[2].andand.text
          @person.contract.end_year = @contract[3].andand.text
          @person.contract.free_agent_year = @contract[4].andand.text
          @person.contract.save
        
  end
end
