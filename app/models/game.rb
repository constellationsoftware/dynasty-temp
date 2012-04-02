class Game < ActiveRecord::Base
    self.table_name = 'dynasty_games'

    belongs_to :home_team, :class_name => 'Team', :inverse_of => :home_games
    belongs_to :away_team, :class_name => 'Team', :inverse_of => :away_games
    belongs_to :league
    belongs_to :event, :class_name => 'Events::Base', :polymorphic => true, :conditions => { :type => 'Events::ScoreGames' }
    has_many :transactions, :as => :eventable, :class_name => 'Account'

    scope :for_week, lambda { |x| where{ week == my{ x } } }
    scope :with_teams, joins{[ home_team, away_team ]}.includes{[ home_team, away_team ]}
    scope :with_home_team, joins{ home_team }.includes{ home_team }
    scope :with_away_team, joins{ away_team }.includes{ away_team }
    scope :scored, where{ (home_team_score != nil) & (away_team_score != nil) }
    scope :unscored, where{ (home_team_score == nil) | (away_team_score == nil) }

    def home?(team); home_team === team end
    def away?(team); !home?(team) end
    def opponent_for(team); home?(team) ? away_team : home_team end

    def score_for(team)
        if scored?
            home?(team) ? home_team_score : away_team_score
        end
    end

    def won?(team)
        if scored?
            if home?(team)
                home_team_score >= away_team_score # home teams win ties
            else
                away_team_score > home_team_score
            end
        end
    end

    def scored?
        !(self.home_team_score.nil? || away_team_score.nil?)
    end

    def week
        game_season = Season.for_date(self.date).first
        # we add one since we're referenced off the start date
        ((self.date - game_season.start_date) / 7).to_i + 1
    end
end
