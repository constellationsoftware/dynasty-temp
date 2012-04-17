class Draft < ActiveRecord::Base
    self.table_name = 'dynasty_drafts'
    include EnumSimulator

    #constants
    # TODO: put this in the controller, probably
    CHANNEL_PREFIX = 'presence-draft-'
    DELAY_BETWEEN_PICKS = 1

    #is_timed

    belongs_to :league
    has_many :teams, :through => :league
    has_many :users, :through => :teams
    has_many :picks, :dependent => :destroy
    belongs_to :current_pick, :class_name => 'Pick'

    default_scope order { [isnull(finished_at).desc, id.desc, finished_at.desc] }
    scope :active, where { status.not_eq 'finished' }
    scope :paused, where { status.eq 'paused' }
    scope :finished, where { status.eq 'finished' }

    enum :status, [:started, :finished, :paused]

    attr_accessible :start_datetime

    def start
        # Sets up parameters necessary to start the draft
        if !(self.status === :started)
            self.status = :started
            self.started_at = Time.now
            self.current_pick = self.get_current_pick

            self.save!
        end
    end

    # reset the draft
    # TODO: This needs some TLC ASAP. Only PTRs recently drafted should be removed, not all of them!
    def reset
        Pick.destroy_all(:draft_id => self.id) # destroy picks
        # PlayerTeam.destroy_all(:league_id => self.league_id)
        self.create_pick_records # create new picks

        self.finished_at = nil
        self.status = nil
        self.started_at = nil
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
    def advance(force_finish = false)
        # set the current pick to the next "free" pick slot
        self.current_pick = self.get_current_pick

        # this loop iterates through eligible pick slots, autopicking for offline
        # users and returning when a pick for an online user is reached
        autopick_iterations = 1
        while !self.current_pick.nil? and (!self.current_pick.team.is_online or !!self.current_pick.team.autopick or force_finish) and !(self.status === :finished)
            puts self.current_pick.team.name + ' IS SLEEPING!'
            # make the "auto-pick"
            autopick_player = self.best_player
            self.make_pick(autopick_player)

            # notify clients of the pick
            # TODO: figure out a better place to put this, maybe as a callback from the controller
            puts 'pushing pick update to channel: ' + CHANNEL_PREFIX + self.league.slug
            payload = {
                :player => { :id => autopick_player.id, :name => autopick_player.full_name },
                :team => { :id => self.current_pick.team.id, :name => self.current_pick.team.name },
                :pick => self.current_pick
            }
            Pusher[CHANNEL_PREFIX + self.league.slug].delay(:run_at => (Time.now + (autopick_iterations * Draft::DELAY_BETWEEN_PICKS))).trigger('draft:pick:update', payload) unless (self.online.count === 0 or force_finish)

            self.current_pick = self.get_current_pick
            autopick_iterations += 1
        end

        # if the draft isn't over, then the "current pick" is for a live user
        if !(self.current_pick.nil?) and !(self.status === :finished)
            pick_user_id = self.current_pick.team.uuid

            # patches up things with the player suggestions until we drop Pusher for good
            players = Player.filter_positions(self.current_pick.team)
                .available(self)
                .with_name
                .with_points
                .with_position
                .with_contract
                .with_favorites(self.current_pick.team)
                .order { points.points.desc }
                .page(1).per(5)
            payload = Jbuilder.encode do |json|
                json.(players) do |json, player|
                    json.id                     player.id
                    json.name do |json|
                        json.first_name         player.name.first_name
                        json.last_name          player.name.last_name
                        json.full_name          player.name.full_name
                    end
                    json.contract do |json|
                        json.amount             player.contract.amount
                        json.bye_week           player.contract.bye_week
                    end
                    json.position do |json|
                        json.abbreviation       player.position.abbreviation
                    end
                    json.points do |json|
                        json.points             player.points.first.points
                        json.defensive_points   player.points.first.defensive_points
                        json.passing_points     player.points.first.passing_points
                        json.rushing_points     player.points.first.rushing_points
                        json.sacks_against_points player.points.first.sacks_against_points
                        json.scoring_points     player.points.first.scoring_points
                        json.special_teams_points player.points.first.special_teams_points
                        json.games_played       player.points.first.games_played
                        #json.consistency        player.points.first.consistency
                    end
                    json.favorites do |json|
                        json.sort_order         player.favorites.first ? player.favorites.first.sort_order : nil
                    end
                end
            end
            Pusher[Draft::CHANNEL_PREFIX + self.league.slug].delay(:run_at => (Time.now + (autopick_iterations * Draft::DELAY_BETWEEN_PICKS))).trigger('draft:pick:start-' + pick_user_id, payload) unless (self.online.count === 0 or force_finish)
            Pusher[Draft::CHANNEL_PREFIX + self.league.slug].delay(:run_at => (Time.now + (autopick_iterations * Draft::DELAY_BETWEEN_PICKS))).trigger('draft:pick:start', {:team => self.current_pick.team.name}, self.current_pick.team.last_socket_id )

        else
            Pusher[Draft::CHANNEL_PREFIX + self.league.slug].delay(:run_at => (Time.now + (autopick_iterations * Draft::DELAY_BETWEEN_PICKS))).trigger('draft:finish', {}) unless (self.online.count === 0 or force_finish)
        end

        self.save!
    end

    # what users/teams are online in the draft
    def online
        self.teams.online
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


    # finding the current team up to pick
    def get_current_pick
        return self.picks.where(:player_id => nil).first
    end

    # most recent pick
    def last_pick_made
        p = self.get_current_pick.pick_order - 1
        self.picks.find_by_pick_order(p)
    end

    # most recently picked player
    def last_player_picked
        @pick = self.last_pick_made.player_id
        Player.find(@pick)
    end

    # seeing what players have been picked
    def already_picked
        @picked = self.picks.where("player_id >= ?", 1).map(&:player_id)
        Player.find(@picked)
    end

    # automatically picking the best available player
    def auto_pick
        p = self.get_current_pick
        unless p.team.is_online?
            p.player_id = self.best_player.id
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
        Player.available
    end

    # the supposedly best pick
    # TODO: hacky; refactor this sometime
    def best_player
        Player.filter_positions(self.current_pick.team).available(self.current_pick.team.league).with_points.with_contract.order { points.points.desc }.page(1).per(1).first
    end
end
