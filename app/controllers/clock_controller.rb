class ClockController < ApplicationController
  #def next_week
  #  @clock = Clock.first
  #  @clock.time = @clock.time.today + 7 
  #  @clock.time
  #end

  def show
    @clock = Clock.first
    session[:return_to] ||= request.referer
    respond_to do |format|
      format.html { render :json => @clock.time.to_date}
      format.json { render :json => @clock }
    end
  end

  def next_week
    @clock = Clock.first
    @clock.next_week
    session[:return_to] ||= request.referer
    redirect_to session[:return_to]
  end

  def reset
    @clock = Clock.first
    @clock.reset
    session[:return_to] ||= request.referer
    redirect_to session[:return_to]
  end

  def update
    redirect_to session[:return_to]
  end
end