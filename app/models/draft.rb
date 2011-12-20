# TODO: clean up unused methods and scrutinize performance of existing ones dealing with queries
class Draft < ActiveRecord::Base
  include EnumSimulator

  #constants
  # TODO: put this in the controller, probably
  CHANNEL_PREFIX = 'presence-draft-'

  #is_timed

  belongs_to :league
  has_many :teams, :through => :league
  has_many :users, :through => :teams
  has_many :picks
  belongs_to :current_pick, :class_name => 'Pick'

  default_scope order("ISNULL(drafts.finished_at) DESC, drafts.id DESC, drafts.finished_at DESC")
  scope :active, where{status.not_eq 'finished'}
  scope :paused, where{status.eq 'paused'}
  scope :finished, where{status.eq 'finished'}

  enum :status, [:started, :finished, :paused]

  def current_pick
    pick = Pick.find(self.current_pick_id)
    return pick unless !pick
  end

  # start the draft
  def start
    # if the draft isn't started, start it. otherwise, pick up where we left off
    if !(self.status === :started)
      # generate picks
      i = 0
      round = 1
      teams = self.league.teams

      self.number_of_rounds.times do
        if round.odd?
            roundsort = teams.sort
        else
            roundsort = teams.sort.reverse
        end
        roundsort.each do |team|
            i += 1
            pick = Pick.new
            pick.draft_id = self.id
            pick.team_id = team.id
            pick.pick_order = i
            pick.round = round
            pick.save!
        end
        round += 1
      end

      self.status = :started
      self.started_at = Time.now
      self.save!
    end

    self.advance
  end

  # end the draft
  def finish
    if !(self.status === :finished)
      self.status = :finished
      self.finished_at = Time.now
      self.save!
    end
  end

  # reset the draft
  def reset
     # destroy picks
    Pick.destroy_all(:draft_id => self.id)

    self.status = nil
    self.started_at = nil
    self.finished_at = nil
    self.current_pick = nil
    self.save!
  end

  # commits a user pick
  def make_pick(player)
    pick = self.current_pick
    pick.player = player
    pick.save!
    return pick
  end

  ##
  # This method advances the draft after a pick is made, or on draft start.
  #
  def advance
    # set the current pick to the next "free" pick slot
    self.current_pick = self.get_current_pick
    
    # this loop iterates through eligible pick slots, autopicking for offline
    # users and returning when a pick for an online user is reached
    autopick_iterations = 1
    while !self.current_pick.nil? and !self.current_pick.team.is_online
      puts self.current_pick.team.name + ' IS SLEEPING!'
      # make the "auto-pick"
      autopick_player = self.best_player
      self.make_pick(autopick_player)

      # notify clients of the pick
      # TODO: figure out a better place to put this, maybe as a callback from the controller
      puts 'pushing pick update to channel: ' + CHANNEL_PREFIX + self.league.slug
      Pusher[CHANNEL_PREFIX + self.league.slug].delay(:run_at => (Time.now + (autopick_iterations * 5))).trigger('draft:pick:update', self.current_pick)

      self.current_pick = self.get_current_pick
      autopick_iterations += 1
    end

    # if the draft isn't over, then the "current pick" is for a live user
    if !(self.status === :finished)
      pick_user_id = self.current_pick.team.uuid
      payload = {
        :players => Salary.by_rating.by_position.available.limit(5)
      }
      Pusher[Draft::CHANNEL_PREFIX + self.league.slug].delay(:run_at => (Time.now + (autopick_iterations * 5))).trigger('draft:pick:start-' + pick_user_id, payload)
    end

    self.save!
  end

  # what users/teams are online in the draft
  def online
    user_teams = self.teams.online
  end

# push the draft status
  def push_draft_status
    payload = {
      :draft => self,
      :current_pick => self.get_current_pick,
      :teams => self.teams.inspect,
      :league => self.league.inspect,
      :users => self.users.inspect

    }
    Pusher[CHANNEL_PREFIX + self.league.slug].trigger_async('draft:status:received', payload)
  end

  # push available players
  def push_available_players
    payload = {
      :draft => self,
      :available_players => self.available_players,
      :best_player => self.best_player

    }
    Pusher[CHANNEL_PREFIX + self.league.slug].trigger_async('draft:available:received', payload)
  end

  # push pick update
  def push_pick_update

    test = {
      :user_id => self.last_pick_made.team.user_id,
      :user_name => self.last_pick_made.team.user.name,
      :player => self.last_player_picked
    }
    Pusher[CHANNEL_PREFIX + self.league.slug].trigger_async('draft:pick:received', test)


    payload = {
     :draft => self,
     :player_picked => self.last_player_picked,
     :current_pick => self.get_current_pick,
     :active_user => self.get_current_pick.team.user
    }
    Pusher[CHANNEL_PREFIX + self.league.slug].trigger_async('draft:pick_update:received', payload)

    # send app the new current user
    event_name = 'draft:pick:user_' + self.get_current_pick.team.user.id.to_s
    Pusher[CHANNEL_PREFIX + self.league.slug].trigger_async(event_name, payload)
 end


  # finding the current user_team up to pick 
  def get_current_pick
    return self.picks.where(:person_id => nil).first
  end

  # most recent pick
  def last_pick_made
    p = self.get_current_pick.pick_order - 1
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

  # automatically picking the best available player  
  def auto_pick
    p = self.get_current_pick
    unless p.team.is_online?
      p.person_id = self.best_player.id
      p.picked_at = Time.now
      p.save!
      #self.push_pick_update
    end
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
