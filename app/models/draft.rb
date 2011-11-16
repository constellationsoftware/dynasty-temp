class Draft < ActiveRecord::Base
  #is_timed

  belongs_to :league
  has_many :teams, :through => :league
  has_many :users, :through => :teams
  has_many :picks

  # requires :association, :league
  # requires :attribute, :number_of_rounds
  # locks :association, :league

  # scopes for draft status 
  scope :pending, where(:started => 0)
  scope :started, where(:started => 1)
  scope :unfinished, where(:finished => 0)
  scope :finished, started.where(:finished => 1)
  scope :active, started.unfinished


  # start the draft 
  def start
    unless self.started
      self.started = 1
      

      i = 0
      round = 0
      teams = self.league.teams

      self.number_of_rounds.times do
        round += 1
        if round.odd?
           roundsort = teams.sort
        else
           roundsort = teams.sort.reverse
        end
        roundsort.each do |team|
           i += 1
           @pick = Pick.new
           @pick.draft_id = self.id
           @pick.team_id = team.id
           @pick.pick_order = i
           @pick.save!
       end
    end
    self.started_at = Time.now
    self.current_pick = 1
    self.save!

    end
  end

  # end the draft
  def finish
    if self.started
      self.finished = 1
      self.finished_at = Time.now
      self.save!
    end
  end

  # reset the draft
  def reset
    if self.started
        self.finished = 0
        self.started = 0
        self.started_at = nil
        self.finished_at = nil
        self.current_pick = 1
        self.save!
    end
  end

# what users/teams are online in the draft
def online
  user_teams = self.teams.online
end




  # push the draft status
  def push_draft_status
    payload = {
      :draft => self,
      :current_pick => self.open_pick,
      :teams => self.teams.inspect,
      :league => self.league,
      :users => self.users

    }
    Pusher['presence-draft'].trigger_async('draft:status:received', payload)
  end

  # push available players
  def push_available_players
    payload = {
      :draft => self,
      :available_players => self.available_players,
      :best_player => self.best_player

    }
    Pusher['presence-draft'].trigger_async('draft:available:received', payload)
  end

  # push pick update
  def push_pick_update

    test = {
      :user_id => self.last_pick_made.team.user_id,
      :user_name => self.last_pick_made.team.user.name,
      :player => self.last_player_picked
    }
    Pusher['presence-draft'].trigger_async('draft:pick:received', test)


    payload = {
     :draft => self,
     :player_picked => self.last_player_picked,
     :current_pick => self.open_pick,
     :active_user => self.open_pick.team.user
    }
    Pusher['presence-draft'].trigger_async('draft:pick_update:received', payload)

    # send app the new current user
    event_name = 'draft:pick:user_' + self.open_pick.team.user.id.to_s
    Pusher['presence-draft'].trigger_async(event_name, payload)
    self.check_next_pick
 end

  def check_next_pick
    @next_pick = self.open_pick
    unless @next_pick.team.is_online
      auto_pick
    end
  end

  # finding the current user_team up to pick 
  def open_pick
    p = self.picks.where(:person_id => nil).first
    self.current_pick = p.pick_order
    p
  end

  # most recent pick
  def last_pick_made
    p = self.open_pick.pick_order - 1
    self.picks.find_by_pick_order(p)
  end

  # most recently picked player
  def last_player_picked
    @pick = self.last_pick_made.person_id
    Salary.find(@pick)
  end

  # seeing what players have been picked
  def already_picked
    @picked = self.picks.where("person_id >= ?", 1).map(&:person_id)
    Salary.find(@picked)
  end

  # make a pick from the front-end
  def make_pick
    # do whatever here....

    # then push the update
    self.push_pick_update

  end

  # automatically picking the best available player  
  def auto_pick
    p = self.open_pick
    p.person_id = self.best_player.id
    p.picked_at = Time.now
    p.save!
    self.push_pick_update
  end

  # DANGER! this will make all the picks automatically DANGER!
  def draft_auto_pick
    self.picks.count
    while open_pick.pick_order < self.picks.count  
      auto_pick
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
    best = available_players.first
  end
end
