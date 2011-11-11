class Draft < ActiveRecord::Base
  #is_timed

  belongs_to :league
  has_many :teams, :through => :league
  has_many :users, :through => :teams
  has_many :picks

  # requires :association, :league
  # requires :attribute, :number_of_rounds
  # locks :association, :league

  scope :active, where('drafts.started = 1 AND drafts.finished != 1')

  # push the draft status
  def push_draft_status
    payload = {
      :draft => self,
      :current_pick => self.current_pick,
      :teams => self.teams.inspect,
      :league => self.league.inspect,
      :users => self.users.inspect

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
     :current_pick => self.current_pick,
     :active_user => self.current_pick.team.user
    }
    Pusher['presence-draft'].trigger_async('draft:pick_update:received', payload)

    # send app the new current user
    event_name = 'draft:pick:user_' + self.current_pick.team.user.id.to_s
    Pusher['presence-draft'].trigger_async(event_name, payload)
 end


  # finding the current user_team up to pick
  def current_pick
    self.picks.where(:person_id => nil).first
  end

  # most recent pick
  def last_pick_made
    p = self.current_pick.pick_order - 1
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
    p = self.current_pick
    p.person_id = self.best_player.id
    p.picked_at = Time.now
    p.save!
    self.push_pick_update

  end

  # DANGER! this will make all the picks automatically DANGER!
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
