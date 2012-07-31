# == Schema Information
#
# Table name: dynasty_teams
#
#  id             :integer(4)      not null, primary key
#  league_id      :integer(4)
#  name           :string(50)      not null
#  user_id        :integer(4)      not null
#  uuid           :binary(255)
#  balance_cents  :integer(8)      default(0), not null
#  autopick       :boolean(1)      default(FALSE)
#
class Team < ActiveRecord::Base
    include Redis::Objects

    resourcify
    self.table_name = 'dynasty_teams'
    money :balance, :cents => :balance_cents
    counter :sessions, :start => 0

    belongs_to :user
    belongs_to :league, :inverse_of => :teams, :counter_cache => true
    has_many :favorites
    has_many :picks
    has_many :player_teams
    has_many :players, :through => :player_teams
    has_many :reserve_player_teams, :class_name => 'PlayerTeam', :foreign_key => :team_id, :conditions => { :lineup_id => nil }
    has_many :reserve_players, :through => :reserve_player_teams, :source => :player
    has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id', :order => :date
    has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id', :order => :date
    has_many :accounts_receivable, :as => :receivable, :class_name => 'Account'
    has_many :accounts_payable, :as => :payable, :class_name => 'Account'
    #has_many :events, :through => :accounts

    scope :with_players, joins{ players }.includes{ players }
    scope :with_games, joins{[ :home_games, :away_games ]}.includes{[ :home_games, :away_games ]}
    scope :with_picks, joins{ picks }.includes{ picks }

    attr_accessible :name, :motto, :logo
    validates_presence_of :name
    validates_uniqueness_of :name

    has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/paperclip/default.jpg"

    def payments
      Account.where(:payable_id => self.id)
    end

    def receipts
      Account.where(:receivable_id => self.id)
    end

    def player_payments
     Account.where(:type => "PlayerAccount")
    end

    def all_accounts
      accounts = self.accounts_receivable + self.accounts_payable
      accounts.sort! { |a, b|  a.transaction_datetime <=> b.transaction_datetime }
    end

    def events
      self.accounts_receivable.pluck(:event_id).uniq + self.accounts_payable.pluck(:event_id).uniq
    end

    def get_all_events
      Events::Base.find(self.events)
    end

    def get_event_accounts(event)
      Account.where(:event_id => event)
    end

    # home and away games ordered by week by default
    def games
        #(self.home_games + self.away_games).sort{ |a, b| a.send(order.to_s) <=> b.send(order.to_s) }
        Game.by_team(id).order{ date }
    end

    def salary_total
        Team.joins{ picks.player.contract }
            .select{ coalesce(sum(picks.player.contract.amount), 0).as('total') }
            .where{ id == my { self.id } }.first.total.to_f
    end

    def games_played
      self.games.scored
    end

    def is_offline
        self.offline
    end

    def record
        record = self.games_played.collect do |game|
            outcome = self.won? game
            break if outcome.nil?
            outcome ? 1 : 0
        end
        record || []
    end

    def games_won
      self.record.sum
    end

    def games_lost
      self.games_played.count - self.games_won.to_i
    end

    def rating
      self.games_won - self.games_lost
    end

    def won?(game); game.won?(self) end
    def lost?(game); !won?(game) end

    # TODO: When we get some injury data, modify this to exclude injured players
    def fill_lineup_for_game(game)
        empty_slots = Lineup.with_positions.empty(self.id).order{ id }
        unless empty_slots.empty?
            week = game.week
            reserve_player_teams = self.reserve_player_teams.joins{[ player.contract, player.position, player.points ]}
                .includes{[ player.contract, player.position ]}
                .where{ player.contract.bye_week != my{ week } }
                .order{ player.points.points.desc }
                .to_a
            empty_slots.each do |empty_slot|
                player_team = reserve_player_teams.find do |player_team|
                    empty_slot.eligible_for? player_team.player
                end
                unless player_team.nil?
                    #puts "Found player (#{player_team.player.name.full_name} #{player_team.player.position.name}) for #{empty_slot.position.name}"
                    reserve_player_teams.delete player_team
                    player_team.lineup = empty_slot
                    player_team.save
                end
            end
        end
    end

    # fetches a player for autopick, considering favorites
    def autopick_player
        # when autopicking, we use the next unfilled slot in the roster in lineup order
        # if the user's favorites list contains a valid player for the lineup slot, it is picked
        if self.favorites.count > 0
            # get the next empty slot ID for autopicking
            position_id = Lineup.with_positions.empty(self.id).order{ id }.first.id

            favorite_ids = self.favorites.collect{ |f| f.player_id }
            player = Player.available(self.league_id).recommended(self.id)
                .where{ id >> (favorite_ids) }
                .first
        end

        # TODO: figure out a good way to batch these. Maybe at the message pushing level?
        player ||= Player.available(self.league_id).recommended(self.id).first
        player
    end

    # use uuid as a string
    def uuid
        uuid = self.read_attribute(:uuid)
        UUIDTools::UUID.parse_raw(uuid).to_s unless uuid.nil?
    end

    def self.find_by_uuid(uuid_s)
        super UUIDTools::UUID.parse(uuid_s).raw
    end

    def online?; self.sessions.value > 0 end
    def autopicking?; self.autopick end
end
