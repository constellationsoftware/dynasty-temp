class ClockController < ApplicationController
    #def next_week
    #  @clock = Clock.first
    #  @clock.time = @clock.time.today + 7
    #  @clock.time
    #end

    def show
        @clock = Clock.first
        respond_to do |format|
            format.html { render :json => @clock.time.to_date }
            format.json { render :json => @clock }
        end
    end

    def next_week
        @clock = Clock.find(2)

        @clock.next_week
        if params[:league_id]
            # calculate points for the passed-in league
            league = League.joins{teams}.includes{teams}.where{id == my{params[:league_id]}}.first
            @clock.calculate_points_for_league(league) if league

            league.teams.each { |ut|
                    schedule = ut.schedules.where('week = ?', @clock.week).first
                    schedule.team_score = ut.games.where('week = ?', @clock.week).first.points
                    schedule.opponent_score = UserTeam.find(schedule.opponent_id).games.where('week = ?', @clock.week).first.points
                    schedule.outcome = 1 if schedule.team_score > schedule.opponent_score
                    schedule.outcome = 0 if schedule.team_score < schedule.opponent_score
                    # calculate win/loss payouts
                    @game = ut.games.where('week = ?', @clock.week).first
                    if schedule.outcome == 1
                        @game.winnings = 5000000
                        @game.save

                    end
                    if schedule.outcome == 0
                        @game.winnings = 2500000
                        @game.save
                    end
                    @game.save
                    ut.balance += @game.winnings.to_money
                    ut.save
                    schedule.save
            }


    end

    session[:return_to] ||= request.referer
    redirect_to :back
  end

  def reset
    @clock = Clock.first
    @clock.reset
    session[:return_to] ||= request.referer
    redirect_to :back
  end

  def present
    @clock = Clock.first
    @clock.present
    session[:return_to] ||= request.referer
    redirect_to :back
  end

  def update

  end
end
