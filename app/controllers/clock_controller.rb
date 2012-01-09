class ClockController < ApplicationController
  #def next_week
  #  @clock = Clock.first
  #  @clock.time = @clock.time.today + 7 
  #  @clock.time
  #end

  def show
    @clock = Clock.first
    respond_to do |format|
      format.html { render :json => @clock.time.to_date}
      format.json { render :json => @clock }
    end
  end



  def next_week
    @clock = Clock.first
    @clock.next_week

    if params[:league_id]
      # calculate points for the passed-in league
      league = League.joins{teams}.includes{teams}.where{id == my{params[:league_id]}}.first
      @clock.calculate_points_for_league(league) if league
    end

    league.teams.each do |ut|
      schedule = ut.schedules.where(:outcome => nil).first
      schedule.team_score = ut.games.where(:week => schedule.week).first.points
      schedule.opponent_score = UserTeam.find(schedule.opponent_id).games.where(:week => schedule.week).first.points
      if schedule.team_score > schedule.opponent_score
        schedule.outcome = 1
      end

      if schedule.team_score < schedule.opponent_score
        schedule.outcome = 0
      end
      schedule.save
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