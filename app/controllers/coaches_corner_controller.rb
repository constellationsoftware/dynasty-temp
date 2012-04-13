class CoachesCornerController < ApplicationController
    include CoachesCornerHelper
    before_filter :authenticate_user!
    sub_pages :player_depth, :game_review, :league_review
    helper_method :get_player

    def player_depth
        @team = current_user.team
        @lineups = Lineup.with_positions.joins{[ player_teams, player_teams.player.outer ]}
            .includes{[ player_teams ]}
            .where{ player_teams.team_id == my{ @team.id } }
    end

    def game_review
        @team = current_user.team
        @games = @team.games
        @week = Clock.first.week
    end

    def league_review

    end

    def get_player(player_id)
        Player.where{ id == my{ player_id } }
            .joins{[ name, contract, position ]}
            .includes{[ name, contract, position ]}
            .first
    end
end
