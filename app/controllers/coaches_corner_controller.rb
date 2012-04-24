class CoachesCornerController < ApplicationController
    include CoachesCornerHelper
    before_filter :authenticate_user!, :set_team
    sub_pages :game_review, :league_review, :manage_starters
    helper_method :get_player

    def manage_starters
        Lineup.reflect_on_association(:player_teams).options[:conditions] = "#{PlayerTeam.table_name}.team_id = #{@team.id}"
        @lineups = Lineup.with_positions.joins{ player_teams.outer }
            .includes{ player_teams }
            .order{ id }
    end

    def swap
        @team = current_user.team
        from_player = PlayerTeam.find_by_team_id_and_lineup_id @team.id, params[:from_id]
        to_player = PlayerTeam.find_by_team_id_and_lineup_id @team.id, params[:to_id]
        if from_player || to_player
            from_player.update_attributes! :lineup_id => params[:to_id].to_i if from_player
            to_player.update_attributes! :lineup_id => params[:from_id].to_i if to_player
            render :json => true
        end
    end

    def game_review
        @game_weeks = []
        games = @team.league.games.order{ date }
        games_per_week = (Settings.league.capacity / 2)
        weeks = Settings.season_weeks
        (weeks).times do |i|
            @game_weeks << games.shift(games_per_week)
        end
        @week = Clock.first.week
    end

    def league_review
        @games = []
        games = @team.league.games.order{ date }
        games_per_week = (Settings.league.capacity / 2)
        weeks = Settings.season_weeks
        (weeks).times do |i|
            @games << games.shift(games_per_week)
        end
        @week = Clock.first.week
    end

    def get_player(player_id)
        Player.where{ id == my{ player_id } }
            .joins{[ name, contract, position ]}
            .includes{[ name, contract, position ]}
            .first
    end

    protected
        def set_team
            @team = current_user.team
        end
end
