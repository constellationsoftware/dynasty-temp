class Draft < ActiveRecord::Base
  #is_timed
  #Note: Drafts will have a fixed # of rounds (still determining, probably low 20s) and each user must pick in each round.

  belongs_to :league
  has_many :teams, :through => :league
  has_many :picks

 # requires :association, :league
 # requires :attribute, :number_of_rounds
 # locks :association, :league

  def self.current(league)
    find_by_league_id_and_started_and_finished(
      league.id, true, false)
  end

  def self.current_or_new(league)
    d = current(league)
    if d.nil?
      d = create(:league => league, :started => true, :finished => false)
    end
    d
  end

  def current_round
    r = rounds.where(:started => true, :finished => false).first
    if r.nil?
    r = rounds.create(:started => true, :finished => false)
    end
    r
  end

  def number_of_started_rounds
    rounds.where(:started => true).count
  end

  def available_players
    person_ids = picks.map(&:person_id)
    if person_ids.empty?
      Person.find(:all)
    else
      Person.find(
        :all,
        :conditions => ['id not in (?)', picks.map(&:person_id)],
        :include => :display_name)
    end
  end


end
