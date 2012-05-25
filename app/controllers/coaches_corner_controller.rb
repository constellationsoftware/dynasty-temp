class CoachesCornerController < ApplicationController
    include CoachesCornerHelper
    before_filter :authenticate_user!, :set_team
    sub_pages :game_review,  :manage_starters
    helper_method :get_player

    def manage_starters
        Lineup.reflect_on_association(:player_teams).options[:conditions] = "#{PlayerTeam.table_name}.team_id = #{@team.id}"
        @lineups = Lineup.with_positions.joins{ player_teams.outer }
            .includes{ player_teams }
            .order{ id }

        # get lineups for opponent
        next_game = @team.games.unscored.order{ date }.first
        opponent = next_game.opponent_for(@team)
        @opponent_lineup = PlayerTeam.joins{[ player.name, player.position ]}
            .includes{[ player.name, player.position ]}
            .where{ (team_id == my{ opponent.id }) & (lineup_id != nil) }

        @reserve = @team.reserve_players
    end

    def game_review
        @game_weeks = []
        games = @team.league.try(:games)
        unless games.nil?
            games = games.order{ date }
            games_per_week = (Settings.league.capacity / 2)
            weeks = Settings.season_weeks
            (weeks).times do |i|
                @game_weeks << games.shift(games_per_week)
            end
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
