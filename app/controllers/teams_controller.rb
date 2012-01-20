class TeamsController < InheritedResources::Base
    before_filter :authenticate_user!
    defaults :resource_class => UserTeam
    custom_actions :resource => :manage

    has_scope :with_player_contracts, :type => :boolean, :default => false, :only => :manage do |controller, scope|
        scope.joins { players.contract }.includes { players.contract }
    end
    has_scope :with_schedules, :type => :boolean, :default => true, :only => :manage do |controller, scope|
        scope.joins { schedules }.includes { schedules }
    end

    def manage
        manage! do |format|
            #raise unless current_user === @team.user

            #session[:user_team_id] = @team.id
            max_week = Schedule.select{max(week).as('week')}.where{team_id == my{@team.id}}.first.week.to_i
            week = Clock.first.week
            game = @team.schedules.for_week(week).with_opponent.first
            next_game = @team.schedules.for_week(week + 1).with_opponent

            if week > 0
                last_weeks_players = @team.player_team_histories.where(:week => week)
                last_weeks_opponents = game.opponent.player_team_histories.where(:week => week)
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
                .includes{[position, contract, team_link]}
                .where{teams.id == my{@team.id}}
                .order{[position.sort_order, position.designation.desc]}
            players = players.with_points_from_season('current') if week > 0
            players.each do |player|
                payroll_total += player.contract.amount
                player_data = {
                    :player => player,
                    :points => week > 0 ? player.points_for_week(week) : nil
                }
                case player.team_link.depth.to_i
                when 1
                    starters << player_data
                when 0
                    bench << player_data
                else # no points for these guys
                    reserve << player_data
                end
            end
            payroll = payroll_total / max_week

            data = {
                :week => week,
                :max_week => max_week,
                :game => game,
                :next_game => (next_game.nil? ? nil : next_game.first),
                :review => {
                    :last_weeks_players => last_weeks_players,
                    :last_weeks_opponents => last_weeks_opponents,
                    :week => week
                },
                :roster => {
                    :starters => starters,
                    :bench => bench,
                    :reserve => reserve,
                    :week => week,
                    :game_lineup => @team.user_team_lineups.where('week = ?', week).first
                },
                :research => { :all_players_by_position => position_players },
                :trades => {
                    :my_players => PlayerTeamRecord.joins{player.name}.includes{player.name}
                        .where{user_team_id == my{@team.id}},
                    :their_players => PlayerTeamRecord.joins{[player.name, team]}.includes{[player.name, team]}
                        .where{user_team_id != my{@team.id}}
                        .order{[player.name.last_name, player.name.first_name]},
                    :open_trade_offers => Trade.open.find_all_by_initial_team_id(@team.id),
                    :open_trades_received => Trade.open.find_all_by_second_team_id(@team.id),
                    :accepted_trade_offers => Trade.closed.accepted.find_all_by_initial_team_id(@team.id),
                    :accepted_trades_received => Trade.closed.accepted.find_all_by_second_team_id(@team.id),
                    :denied_trade_offers => Trade.closed.denied.find_all_by_second_team_id(@team.id),
                    :denied_trades_received => Trade.closed.denied.find_all_by_initial_team_id(@team.id)
                },

                :waiver => {
                    :waiver_players => @team.league.player_team_records.where(:waiver => 1)
                },

                :sidebar => {
                    :bank_account => {
                        :cap => 75000000,
                        :payroll => payroll,
                        :payroll_total => payroll_total
                    }
                }
            }
            format.html { respond_with @team, :locals => data }
            #failure.html { redirect_to root_path, :flash => {:info => "You aren't authorized to do that!"} }
        end
        return
        # game outcome
        #if  @team.schedules.where(:week => @team.games.last.week).first
        @last_game = @team.schedules.where(:week => @team.games.last.week).first
        #end
        # Roster and positioning stuff
        @my_lineup = UserTeamLineup.find_or_create_by_user_team_id(@team.id)

        @my_season_payroll = @team.players.to_a.sum(&:amount)
        @my_weekly_payroll = @my_season_payroll / @team.schedules.count

        @my_starters = @team.player_team_records.where { depth == 1 }
        @my_bench = @team.player_team_records.where(:depth => 0)
        @my_ptr = @team.player_team_records
        @my_qb = @my_ptr.qb
        @my_wr = @my_ptr.wr
        @my_rb = @my_ptr.rb
        @my_te = @my_ptr.te
        @my_k = @my_ptr.k

        # Waiver Wire Stuff
        @waiver_players = @league.player_team_records.where(:waiver => 1)
    end
end
