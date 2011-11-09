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

  # finding the current user_team up to pick

  def current_pick
    p = self.picks.where(:person_id => nil).first

  end

  # seeing what players have been picked
  def already_picked
    @picked = self.picks.where("person_id >= ?", 1).map(&:person_id)
    Salary.find(@picked)
  end

  # automatically picking the best available player
  
  def auto_pick
    p = self.current_pick
    already_picked = self.picks.where(:person_id != nil)
    available_players = Salary.all
    best_available = available_players.first
    p.person_id = best_available.id
    p.picked_at = Time.now
    p.save!

  end



  def number_of_started_rounds
    rounds.where(:started => true).count
  end

  def available_players
    picked = self.already_picked
    all_players = Salary.all
    available_players = all_players - picked

  end


end
