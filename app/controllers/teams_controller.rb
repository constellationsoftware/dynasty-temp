class TeamsController < ApplicationController
    before_filter :authenticate_user!

    has_scope :with_player_contracts, :type => :boolean, :default => false, :only => :manage do |controller, scope|
        scope.joins{ players.contract }.includes{ players.contract }
    end
    has_scope :manager_scopes, :type => :boolean, :default => true, :only => :manage do |controller, scope|
        scope.with_games
            .where{ (home_games.home_team_id == controller.request.params[:id]) | (away_games.away_team_id == controller.request.params[:id]) }
    end
    has_scope :with_picks, :type => :boolean

    def new
        @team = Team.new
    end

    def create
        @team = Team.new(params[:team])
        @team.user_id = current_user.id
        if @team.save!
            redirect_to root_path
        end
    end

    def index
        @team = current_user.team
        @teams = apply_scopes(resource_class).where{ league_id == my{ @team.league_id } }
    end

    def manage
        manage! do |format|
            games = @team.games
            max_week = games.size
            week = games.find_index{ |game| game.home_team_score.nil? } || max_week
            game = games[week - 1] if week > 0
            next_game = games[week] if week

            if week > 0
                #last_weeks_players = @team.player_team_snapshots.where(:week => week)
                #last_weeks_opponents = game.opponent.player_team_snapshots.where(:week => week)
            end

            # RESEARCH
            position_players = []
            positions = Position.select{[name, abbreviation]}.all
            positions.each do |position|
                players = Player.with_points_from_season('current')
                    .filter_positions(nil, [position.abbreviation])
                    .with_contract
                    .order{[contract.depth, points.points.desc]}
                position_players << { :name => position.name, :players => players }
            end

            starters = []
            bench = []
            reserve = []
            payroll_total = 0
            players = Player.joins{[teams, position, contract]}
                .includes{[position, contract, player_teams]}
                .where{teams.id == my{@team.id}}
                .order{[position.sort_order, position.designation.desc]}
            players = players.with_points_from_season('current') if week > 0
            players.each do |player|
                payroll_total += player.contract.amount
                #player_data = {
                #    :player => player,
                #    :points => week > 0 ? player.points_for_week(week) : nil
                #}
                #case player.player_teams.depth.to_i
                #when 1
                #    starters << player_data
                #when 0
                #    bench << player_data
                #else # no points for these guys
                #    reserve << player_data
                #end
            end
            payroll = payroll_total / max_week

            data = {
                :week => week,
                :max_week => max_week,
                :game => game,
                :next_game => next_game,
                :review => {
                    #:last_weeks_players => last_weeks_players,
                    #:last_weeks_opponents => last_weeks_opponents,
                    :week => week
                },
                :roster => {
                    #:starters => starters,
                    #:bench => bench,
                    #:reserve => reserve,
                    #:week => week,
                    #:game_lineup => @team.team_lineups.where('week = ?', week).first
                },
                #:research => { :all_players_by_position => position_players },
                :trades => {
                    :my_players => PlayerTeam.joins{player.name}.includes{player.name}
                        .where{team_id == my{@team.id}},
                    :their_players => PlayerTeam.joins{[player.name, team]}.includes{[player.name, team]}
                        .where{ (team_id != my{@team.id}) & (team.league_id == my{ @team.league_id }) }
                        .order{[player.name.last_name, player.name.first_name]},
                    :open_trade_offers => Trade.open.find_all_by_initial_team_id(@team.id),
                    :open_trades_received => Trade.open.find_all_by_second_team_id(@team.id),
                    :accepted_trade_offers => Trade.closed.accepted.find_all_by_initial_team_id(@team.id),
                    :accepted_trades_received => Trade.closed.accepted.find_all_by_second_team_id(@team.id),
                    :denied_trade_offers => Trade.closed.denied.find_all_by_second_team_id(@team.id),
                    :denied_trades_received => Trade.closed.denied.find_all_by_initial_team_id(@team.id)
                },

                :waiver => {
                    :waiver_players => @team.player_teams.where{ waiver == 1 }
                },

                :sidebar => {
                    :bank_account => {
                        :cap => 75000000,
                        :payroll => payroll,
                        :payroll_total => payroll_total
                    },
                    :schedule => {
                        :games => games,
                        :record => @team.record
                    }
                }
            }
            format.html { respond_with @team, :locals => data }
            #failure.html { redirect_to root_path, :flash => {:info => "You aren't authorized to do that!"} }
        end

        # Waiver Wire Stuff
        #@waiver_players = @league.player_teams.where(:waiver => 1)
    end

    def account
        account! do |format|
            @transactions = Account.where{ ((payable_id == my{ @team.id }) & (payable_type == my{ @team.class.to_s })) | ((receivable_id == my{ @team.id }) & (receivable_type == my{ @team.class.to_s })) }
                .order{ created_at.desc }
        end
    end
end
