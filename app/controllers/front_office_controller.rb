class FrontOfficeController < ApplicationController
    before_filter :authenticate_user!
    sub_pages :roster, :trades, :waivers
    respond_to :html
    helper_method :get_player

    def roster
        @team = current_user.team
        Lineup.reflect_on_association(:player_teams).options[:conditions] = "#{PlayerTeam.table_name}.team_id = #{@team.id}"
        @lineups = Lineup.with_positions.joins{ player_teams.outer }
            .includes{ player_teams }
            .order{ id }
    end

    def trades
        @team = current_user.team
        players = PlayerTeam.joins{ player.name }.includes{ player.name }.where{ team_id == my{ @team.id } }
        @new_trade = Trade.new(:offered_player => players.first)
        @trades = {
            :my_players => players,
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
        @waivers = Waiver.current.all

    end

    def resolve_bids
        @waivers = Waiver.current.all
        @waivers.each do |waiver|

          unless waiver.waiver_bids.first.nil?
            @winning_team = waiver.waiver_bids.first.team
            @ptr = PlayerTeam.find(waiver.player_team_id)
            @ptr.team_id = @winning_team.id
            @ptr.save
          end


          waiver.end_datetime = Clock.first.time
          waiver.save
        end
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
