# == Schema Information
#
# Table name: dynasty_leagues
#
#  id                    :integer(4)      not null, primary key
#  name                  :string(50)      not null
#  created_at            :datetime
#  updated_at            :datetime
#  manager_id            :integer(4)
#  slug                  :string(255)
#  default_balance_cents :integer(8)      default(0), not null
#  public                :boolean(1)      default(TRUE)
#  password              :string(32)
#  teams_count           :integer(4)
#  clock_id              :integer(4)
#  balance_cents         :integer(8)      default(0)
#

class League < ActiveRecord::Base
  resourcify
    self.table_name = 'dynasty_leagues'

    extend FriendlyId
    friendly_id :name, :use => :slugged
    money :balance, :cents => :balance_cents

    # TODO: Create views, access control for users, associate league standings, schedules, and trades for teams

    # TODO: remove the class_name declaration as soon as the scoped controllers are cleaned up
    has_many :teams, :class_name => '::Team'
    has_many :users, :through => :teams
    has_one :draft
    has_many :drafts
    has_many :players, :through => :teams
    has_many :player_teams, :through => :teams
    has_many :games
    belongs_to :manager, :class_name => 'User', :inverse_of => :leagues
    has_many :payments, :as => :receivable
    has_many :receipts, :as => :payable

    validates_presence_of :name
    validates_uniqueness_of :name
    validates_format_of :name, :with => /^[[:alnum:] ]+$/, :on => :create
    validates_length_of :password,
        :minimum => Settings.league.password_min_length,
        :maximum => Settings.league.password_max_length,
        :if => lambda{ |league| league.is_private? }
    #validates :teams, :length => { :maximum => Settings.league.capacity }

    scope :with_manager, joins{ manager }.includes{ manager }
    scope :with_teams, joins{ teams }.includes{ teams }
    scope :filter_by_name, lambda{ |league_name|
        where{ name =~ "#{league_name}%" }
    }
    scope :by_slug, lambda {|value| where{ slug == my{ value } } }

    accepts_nested_attributes_for :draft
    attr_accessible :draft_attributes, :password, :public

    def calculate_game_points(from, to)
        weeks = ((to.to_date - Season.current.start_date) / 7).to_i
        games = Game.where{ (league_id == my{ id }) & (week >> my{ weeks }) }
            .where{ (home_team_score == nil) & (away_team_score == nil) }
        games.each do |game|
            #force_starters game.away_team
            #force_starters game.home_team
            game.home_team_score = points_for_team game.home_team, from, to
            game.away_team_score = points_for_team game.away_team, from, to
            game.save
        end
        return
        self.teams.each do |team|
            points = points_for_team(team, from, to)

            game = Game.new :team_id => team.id, :week => self.clock.week, :points => (points ? points : 0)
            if game.save!
                schedule = team.schedules.where('week = ?', self.clock.week).first
                schedule.team_score = team.games.where('week = ?', self.clock.week).first.points
                schedule.opponent_score = Team.find(schedule.opponent_id).games.where('week = ?', self.clock.week).first.points
                schedule.outcome = 1 if schedule.team_score > schedule.opponent_score
                schedule.outcome = 0 if schedule.team_score < schedule.opponent_score
                schedule.save

                # calculate win/loss payouts
                winnings = schedule.outcome == 1 ? Settings.game.winning_payout : Settings.game.losing_payout
                self.game = team.games.where('week = ?', self.clock.week).first
                self.game.winnings = winnings
                self.game.save
                team.balance += self.game.winnings.to_money
                team.save
            end
        end
    end

    def points_for_team(team, from, to)
        starter_points = PlayerEventPoint.select{ sum(points).as('points') }
            .joins{[ event, player.player_teams.team ]}
            .where{ player.player_teams.team.id == my{ team.id } }
            .where{ player.player_teams.depth == 1 }
            .where{ (event.start_date_time >= from) & (event.start_date_time < to) }
            .first.points
        bench_points = PlayerEventPoint.select{ sum(points).as('points') }
            .joins{[ event, player.player_teams.team ]}
            .where{ player.player_teams.team.id == my{ team.id } }
            .where{ player.player_teams.depth == 0 }
            .where{ (event.start_date_time >= from) & (event.start_date_time < to) }
            .first.points
        starter_points.to_f + (bench_points.to_f / 3)
    end

    # TODO: move this into the team model
    def force_starters(team)
        continue unless team.id == 5
        # force empty player slots to be filled
        Lineup.reflect_on_association(:player_teams).options[:conditions] = "#{PlayerTeam.table_name}.team_id = #{team.id}"
        empty_slots = Lineup.joins{[ position, player_teams.outer, player_teams.position.outer ]}
            .includes{[ position, player_teams.position ]}
            .where{ player_teams.player_id == nil }
        empty_slots.each do |slot|
            team_player = PlayerTeam.select("#{PlayerTeam.table_name}.*")
                .joins{[ player.position_link, player.points ]}
                .where{ (team_id == my{ team.id }) & (lineup_id == nil) }
                .order{ player.points.points.desc }
            if slot.flex
                team_player = team_player.where{ player.position_link.position_id >> my{ slot.position.positions.collect{ |x| x.id } } }
            else
                team_player = team_player.where{ player.position_link.position_id == slot.position_id }
            end
            team_player = team_player.first
            if team_player
                team_player.lineup_id = slot.id
                team_player.depth = 1 # TODO: remove this when depth doesn't matter anymore
                team_player.save
            end
        end
    end

    def is_public?; self.public === true end
    def is_private?; !(is_public?) end

    def self.find_by_slug!(slug)
        league = self.by_slug(slug).first
        league.scoped
    end
end
