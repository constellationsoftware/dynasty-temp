class GamesController < ApplicationController
    respond_to :html, :json

    has_scope :by_league, :as => :league_id
    has_scope :by_team, :as => :team_id
    has_scope :with_points, :type => :boolean do |controller, scope|
        scope
    end
    has_scope :with_players, :type => :boolean
    has_scope :with_teams, :type => :boolean, :default => true

    def index
        @games = apply_scopes(Game).all
    end

    def review
        @games = apply_scopes(Game).all.sort{ |a, b| a.date <=> b.date }
        raise 'Not scoped to a team' unless current_scopes[:team_id]
        @team = Team.find(params[:team_id])
        @games
    end
end
