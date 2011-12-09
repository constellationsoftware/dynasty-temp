class Stat < ActiveRecord::Base
  belongs_to :stat_holder, :polymorphic => true
  belongs_to :stat_coverage, :polymorphic => true
  belongs_to :stat_membership, :polymorphic => true
  belongs_to :stat_repository, :polymorphic => true
  #Stat.includes(:stat_repository)

  def self.event_stat
    where(:stat_coverage_type => 'Event').includes(:stat_repository).includes(:stat_coverage)

  end

  def self.subseason_stat
    where(:stat_coverage_type => 'SubSeason').includes(:stat_repository).includes(:stat_coverage)
  end

  def self.affiliation_stat
    where(:stat_coverage_type => 'Affiliation').includes(:stat_repository).includes(:stat_coverage)
  end
  scope :event, event_stat
  scope :subseason, subseason_stat
  scope :affiliation, affiliation_stat


  def self.passing_stat
    where(:stat_repository_type => 'AmericanFootballPassingStat').includes(:stat_repository).includes(:stat_coverage)
  end

  def self.rushing_stat
    where(:stat_repository_type => 'AmericanFootballRushingStat').includes(:stat_repository).includes(:stat_coverage)
  end

  def self.defensive_stat
    where(:stat_repository_type => 'AmericanFootballDefensiveStat').includes(:stat_repository).includes(:stat_coverage)
  end

  def self.fumbles_stat
    where(:stat_repository_type => 'AmericanFootballFumblesStat').includes(:stat_repository).includes(:stat_coverage)
  end

  def self.sacks_against_stat
    where(:stat_repository_type => 'AmericanFootballSacksAgainstStat').includes(:stat_repository).includes(:stat_coverage)
  end

  def self.scoring_stat
    where(:stat_repository_type => 'AmericanFootballScoringStat').includes(:stat_repository).includes(:stat_coverage)
  end

  def self.special_teams_stat
    where(:stat_repository_type => 'AmericanFootballSpecialTeamStat').includes(:stat_repository).includes(:stat_coverage)
  end
end
