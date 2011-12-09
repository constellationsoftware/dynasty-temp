class Event < ActiveRecord::Base
  default_scope :order => 'start_date_time ASC'
  # TODO: Associated participating players to lock for trading and score calculations
  belongs_to :site
  has_and_belongs_to_many :documents, :join_table => "events_documents"
  has_and_belongs_to_many :medias
  has_many :stats, :as => :stat_coverage
  has_many :participants_events


  def summary
    puts self.start_date_time

    participants = self.participants_events.where{participant_type == 'Team'}
    participants.each do |p|
      puts Team.find(p.participant_id).display_name.full_name
      puts p.score
      puts p.event_outcome
      puts p.alignment
    end
  end

  def gameday
    gameday = self.start_date_time
  end

  def teams
    self.participants_events.where{participant_type == 'Team'}
  end

  def home_team
    @team = self.teams.where{alignment == 'home'}.map(&:participant_id)
    Team.find(@team).first
  end

  def away_team
    @team = self.teams.where{alignment == 'away'}.map(&:participant_id)
    Team.find(@team).first
  end

  def winner
    @team = self.teams.where{event_outcome == 'win'}.map(&:participant_id)
    Team.find(@team).first
  end

  def loser
    @team = self.teams.where{event_outcome == 'loss'}.map(&:participant_id)
    Team.find(@team).first
  end

  def week
    week = self.start_date_time.strftime("%U").to_i - 35
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
    stat = self.stats.passing_stat.where("stat_holder_id = ?", person)
    if stat.nil?
      return "0"
    else
      return stat.first.stat_repository
    end
  end

  def event_rushing_stats(person)
    self.stats.rushing_stat.where("stat_holder_id = ?", person).first.stat_repository
  end

  def event_defensive_stats(person, req_stat)
    stat = self.stats.defensive_stat.where("stat_holder_id = ?", person)

    req_stat
  end

  def event_fumbles_stats(person)
    self.stats.fumbles_stat.where("stat_holder_id = ?", person).first.stat_repository
  end

  def event_sacks_stats(person)
    self.stats.sacks_against_stat.where("stat_holder_id = ?", person).first.stat_repository
  end

  def event_scoring_stats(person)
    self.stats.scoring_stat.where("stat_holder_id = ?", person).first.stat_repository
  end

  def event_special_teams_stats(person)
    self.stats.special_teams_stat.where("stat_holder_id = ?", person).first.stat_repository
  end

  scope :winners, winners
end