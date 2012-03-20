class Game < ActiveRecord::Base
    self.table_name = 'dynasty_games'

    has_many :transactions, :as => :eventable, :class_name => 'Account'
    belongs_to :home_team, :class_name => 'UserTeam'
    belongs_to :away_team, :class_name => 'UserTeam'
    belongs_to :team, :class_name => 'UserTeam', :foreign_key => 'home_team_id'
    belongs_to :league

    scope :for_week, lambda { |x| where{ week == my{ x } } }
    scope :with_teams, joins{[ home_team, away_team ]}.includes{[ home_team, away_team ]}
    scope :with_home_team, joins{ home_team }.includes{ home_team }
    scope :with_away_team, joins{ away_team }.includes{ away_team }

    def home?(team); home_team === team end
    def away?(team); !home?(team) end
    def opponent_for(team); home?(team) ? away_team : home_team end

    def score_for(team)
        if played?
            home?(team) ? home_team_score : away_team_score
        end
    end

    def won?(team)
        if played?
            if home?(team)
                home_team_score >= away_team_score # home teams win ties
            else
                away_team_score > home_team_score
            end
        end
    end

    def played?
        !(self.home_team_score.nil? || away_team_score.nil?)
    end
end
