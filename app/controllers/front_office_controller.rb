class FrontOfficeController < ApplicationController
    sub_pages :roster, :trades, :waivers, :financials
    respond_to :html
    helper_method :get_player

    def roster
        @team = current_user.team
        @lineups = Lineup.with_positions.joins{[ player_teams, player_teams.player.outer ]}
            .includes{[ player_teams ]}
            .where{ player_teams.team_id == my{ @team.id } }
            .order{ position_id }
    end

    def trades
        @team = current_user.team
        @trades = {
            :my_players => PlayerTeam.joins{ player.name }.includes{ player.name }
                .where{ team_id == my{ @team.id } },
            :their_players => PlayerTeam.joins{[player.name, team]}.includes{[player.name, team]}
                .where{ (team_id != my{@team.id}) & (team.league_id == my{ @team.league_id }) }
                .order{[player.name.last_name, player.name.first_name]},
            :open_trade_offers => Trade.open.find_all_by_initial_team_id(@team.id),
            :open_trades_received => Trade.open.find_all_by_second_team_id(@team.id),
            :accepted_trade_offers => Trade.closed.accepted.find_all_by_initial_team_id(@team.id),
            :accepted_trades_received => Trade.closed.accepted.find_all_by_second_team_id(@team.id),
            :denied_trade_offers => Trade.closed.denied.find_all_by_second_team_id(@team.id),
            :denied_trades_received => Trade.closed.denied.find_all_by_initial_team_id(@team.id)
        }
    end

    def waivers

    end

    def financials
      @team = current_user.team
      @accounts = @team.all_accounts
    end

    def get_player(player_id)
        Player.where{ id == my{ player_id } }
            .joins{[ name, contract, position, points ]}
            .includes{[ name, contract, position, points ]}
            .first
    end
end
