class GamesController < ApplicationController
    respond_to :html, :json

    has_scope :by_league, :as => :league_id
    has_scope :by_team, :as => :team_id
    has_scope :with_points, :type => :boolean
    has_scope :with_players, :type => :boolean
    has_scope :with_lineup, :type => :boolean do |controller, scope|
        scope
    end
    has_scope :with_scores, :type => :boolean, do |controller, scope|
        scope.joins{[ player_team_points ]}
            .includes{[ player_team_points ]}
    end
    has_scope :with_teams, :type => :boolean, :default => true
    has_scope :my_team, :type => :boolean, :default => false do |controller, scope|
    end

    def show
        @game = apply_scopes(Game).where{ id == my{ params[:id] } }.first
        current_user_team = current_user.team
        @team = current_user_team unless @game.won?(current_user_team).nil?
    end

    def index
        @games = apply_scopes(Game).all
    end

    def review
        @games = apply_scopes(Game).sort{ |a, b| a.date <=> b.date }
        raise 'Not scoped to a team' unless current_scopes[:team_id]
        @team = Team.find(params[:team_id])
        @games
    end
end
