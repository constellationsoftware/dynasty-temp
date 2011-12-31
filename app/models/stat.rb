class Stat < ActiveRecord::Base

  belongs_to :stat_holder,
    :conditions => [ 'stat_holder_type = ?', 'persons' ]
#, :polymorphic => true
  #belongs_to :stat_coverage, :polymorphic => true
  #belongs_to :event, :foreign_key => :stat_coverage_id, :class_name => "Event"
  belongs_to :stat_membership#, :polymorphic => true
  belongs_to :stat_repository#, :polymorphic => true

  belongs_to :sub_season,
    :foreign_key => :stat_coverage_id,
    :conditions => [ 'stat_coverage_type = ?', 'sub_seasons' ]

  #Stat.joins(:stat_repository).joins(:stat_coverage).joins(:stat_membership)



  def self.event_stat

    where{stat_coverage_type == 'events'}.includes{[stat_repository, stat_coverage]}

  end


  def self.career_stat
    where{context == 'career'}.includes{[stat_repository, stat_coverage]}
  end

  def self.subseason_stat
    where{stat_coverage_type == 'sub_seasons'}.includes{[stat_repository, stat_coverage]}
  end

  def self.last_season
    where{stat_coverage_id == '11'}.includes{[stat_repository, stat_coverage]}
  end

  def self.this_season
    where{stat_coverage_id == '1'}.includes{[stat_repository, stat_coverage]}
  end

  def self.affiliation_stat
    where{stat_coverage_type == 'affiliations'}.includes{[stat_repository, stat_coverage]}
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

  def points
    klass = self.stat_repository_type.classify.constantize
    stat = klass.where{id == my{self.stat_repository_id}}.first
    return stat.points if stat.respond_to? 'points'
  end
end
