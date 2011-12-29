class Stat < ActiveRecord::Base

  belongs_to :stat_holder, :polymorphic => true
  belongs_to :stat_coverage, :polymorphic => true
  #belongs_to :event, :foreign_key => :stat_coverage_id, :class_name => "Event"
  belongs_to :stat_membership, :polymorphic => true
  belongs_to :stat_repository, :polymorphic => true

  #Stat.joins(:stat_repository).joins(:stat_coverage).joins(:stat_membership)



  def self.event_stat

    where(:stat_coverage_type => 'Event').includes(:stat_repository).includes(:stat_coverage)

  end

  def self.career_stat
    where(:context => 'career')
  end

  def self.subseason_stat
    where(:stat_coverage_type => 'SubSeason').includes(:stat_repository).includes(:stat_coverage)
  end

  def self.last_season
    where(:stat_coverage_id => '11').includes(:stat_repository).includes(:stat_repository).includes(:stat_coverage)
  end

  def self.this_season
    where(:stat_coverage_id => '1').includes(:stat_repository).includes(:stat_repository).includes(:stat_coverage)
  end

  def self.affiliation_stat
    where(:stat_coverage_type => 'Affiliation').includes(:stat_repository).includes(:stat_coverage)
  end

  scope :event, event_stat
  scope :subseason, subseason_stat
  scope :affiliation, affiliation_stat

  # @return [Object]
  def coverage_start_date_time
    self.stat_coverage.start_date_time
  end



  def self.future
    where('start_date_time >= ?', Time.now)
  end

  scope :current, where('start_date_time <= ?', Time.now)
  scope :future, future

  # copy stat start_date_time from event into stat table - shitty but expedient

  def self.copy_start_date_time
    @stats = Stat.event_stat.where(:start_date_time => nil)
      @stats.each do |s|
        s.start_date_time = s.coverage_start_date_time
        s.save!
      end; nil
  end




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
