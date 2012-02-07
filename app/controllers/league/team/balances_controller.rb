class League::Team::BalancesController < SubdomainController
    before_filter :authenticate_user!, :get_team!
    defaults :instance_name => 'balance'
    respond_to :json

    protected
        def resource
            payroll_total = PlayerTeamRecord
                .select{ sum(player.contract.amount).as('payroll_total') }
                .joins{ player.contract }
                .where{ (user_team_id == my{ @team.id }) & (current == 1) }
                .first
                .payroll_total
                .to_i

            current_week = Clock.first.week
            max_week = Schedule.select{ max(week).as('week') }.where{ team_id == my{ @team.id } }.first.week.to_i
            cap = 75000000
            cap_difference = (cap - payroll_total)

            @balance = {
                :id => @team.id,
                :balance => @team.balance.format,
                :cap => cap.to_money.format,
                :payroll => (payroll_total / max_week).to_money.format,
                :payroll_total => payroll_total.to_money.format,
                :cap_difference => cap_difference.to_money.format,
                :deficit => !!(cap_difference < 0)
            }
        end

    private
        def get_team!
            @team = UserTeam.where { (league_id == my { @league.id }) & (user_id == my { current_user.id }) }.first
        end
end
