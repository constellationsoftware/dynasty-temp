# == Schema Information
#
# Table name: dynasty_games
#
#  id              :integer(4)      not null, primary key
#  league_id       :integer(4)
#  home_team_id    :integer(4)      not null
#  away_team_id    :integer(4)      not null
#  home_team_score :decimal(4, 1)
#  away_team_score :decimal(4, 1)
#  created_at      :datetime
#  updated_at      :datetime
#  date            :date
#

class Game < ActiveRecord::Base
    self.table_name = 'dynasty_games'

    belongs_to :home_team, :class_name => 'Team', :inverse_of => :home_games
    belongs_to :away_team, :class_name => 'Team', :inverse_of => :away_games
    belongs_to :league
    belongs_to :event, :class_name => 'Events::Base', :polymorphic => true, :conditions => { :type => 'Events::ScoreGames' }
    has_many :transactions, :as => :eventable, :class_name => 'Account'
    has_many :player_team_points
    has_many :scores, :through => :player_team_points, :source => :score
    #has_many :home_team_scores,
    #    :class_name => '::PlayerTeamPoint',
    #    :conditions => proc{ "`#{::Game.table_name}`.`home_team_id` = `#{self.aliased_table_name.to_s}`.`team_id`" }
        #:conditions => lambda{ |x| puts x.aliased_table_name.to_s; "home_team_id = #{self.aliased_table_name.to_s}.team_id" }
    #has_many :away_team_scores,
    #    :class_name => 'PlayerTeamPoint',
    #    :conditions => lambda{ |x| puts x.aliased_table_name.to_s; "away_team_id = #{x.aliased_table_name.to_s}.team_id" }

    scope :by_league, lambda{ |value| where{ league_id == my{ value } } }
    scope :by_team, lambda{ |value| where{ (home_team_id == my{ value }) | (away_team_id == my{ value }) } }
    scope :for_week, lambda { |x| where{ week == my{ x } } }
    scope :with_teams, joins{[ home_team, away_team ]}.includes{[ home_team, away_team ]}
    scope :with_home_team, joins{ home_team }.includes{ home_team }
    scope :with_away_team, joins{ away_team }.includes{ away_team }
    scope :scored, where{ (home_team_score != nil) & (away_team_score != nil) }
    scope :unscored, where{ (home_team_score == nil) | (away_team_score == nil) }
    scope :with_points, joins{ scores }.includes{ scores }

    def home?(team); home_team === team end
    def away?(team); !home?(team) end
    def opponent_for(team); home?(team) ? away_team : home_team end

    def score_for(team)
        if scored?
            home?(team) ? home_team_score : away_team_score
        end
    end

    def player_points_for(team)
        if scored?
            player_team_points.find_all{ |ptp| ptp.team_id === team.id }
                .sort{ |a, b| a.lineup_id <=> b.lineup_id }
        end
    end

    def forfeit?(team)

    end

    def won?(team)
        if scored?
            if home?(team) && !home_team_score.nil?
                away_team_score.nil? || home_team_score >= away_team_score # home teams win ties
            elsif !away_team_score.nil?
                home_team_score.nil? || away_team_score > home_team_score
            else
                false
            end
        end
    end

    def scored?
        !self.home_team_score.nil? || !away_team_score.nil?
    end

    def played?(team)
        team === self.home_team || team === self.away_team
    end

    def week
        game_season = Season.for_date(self.date).first
        # we add one since we're referenced off the start date
        ((self.date - game_season.start_date) / 7).to_i + 1
    end
end
