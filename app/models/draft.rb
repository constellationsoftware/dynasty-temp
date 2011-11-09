class Draft < ActiveRecord::Base
  #is_timed

  belongs_to :league
  has_many :teams, :through => :league
  has_many :picks

 # requires :association, :league
 # requires :attribute, :number_of_rounds
 # locks :association, :league




  # finding the current user_team up to pick
  def current_pick
    self.picks.where(:person_id => nil).first
  end

  # seeing what players have been picked
  def already_picked
    @picked = self.picks.where("person_id >= ?", 1).map(&:person_id)
    Salary.find(@picked)
  end

  # automatically picking the best available player  
  def auto_pick
    p = self.current_pick
    p.person_id = self.best_player.id
    p.picked_at = Time.now
    p.save!
  end

  # this will make all the picks automatically
  def draft_auto_pick
    self.picks.count
    while self.current_pick.pick_order < self.picks.count
      self.auto_pick
    end
  end

  # list of the remaining available players
  def available_players
    picked = self.already_picked
    all_players = Salary.all
    available_players = all_players - picked
  end

  # the supposedly best pick
  def best_player
    best = self.available_players.first
  end


end
