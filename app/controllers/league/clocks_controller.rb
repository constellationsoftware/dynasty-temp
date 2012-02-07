class League::ClocksController < SubdomainController
    custom_actions :resource => [ :next_week, :reset ]
    respond_to :html, :json

    def show
        @clock = Clock.first
        respond_to do |format|
            format.html { render :json => @clock.time.to_date }
            format.json { render :json => @clock.flatten }
        end
    end

    def next_week
        next_week! do |format|
            @clock.next_week
            # calculate points for the passed-in league
            @clock.calculate_points_for_league(@league) if @league

            @league.teams.each do |team|
                schedule = team.schedules.where('week = ?', @clock.week).first
                schedule.team_score = team.games.where('week = ?', @clock.week).first.points
                schedule.opponent_score = UserTeam.find(schedule.opponent_id).games.where('week = ?', @clock.week).first.points
                schedule.outcome = 1 if schedule.team_score > schedule.opponent_score
                schedule.outcome = 0 if schedule.team_score < schedule.opponent_score

                # calculate win/loss payouts
                @game = team.games.where('week = ?', @clock.week).first
                @game.winnings = 2500000
                @game.winnings = 5000000 if schedule.outcome == 1
                @game.save
                team.balance += @game.winnings.to_money
                team.save
                schedule.save
            end

            format.html { render :text => 'success' }
        end
    end

    def reset
        reset! do |format|
            @clock.reset
            format.html { render :text => 'success' }
        end
    end

    def present
        @clock = Clock.first
        @clock.present
        session[:return_to] ||= request.referer
        redirect_to :back
    end

    protected
        def resource
            @clock = Clock.first
        end
end
