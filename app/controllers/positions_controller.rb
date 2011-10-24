class PositionsController < ApplicationController
  def index
    @positions = Position.all

    respond_to do |format|
      format.html # indexbak.html.erb
      format.xml { render :xml => @positions }
    end
  end

  def show
    @position = Position.find(params[:id])
    @players  = @position.person_phases.all
    respond_to do |format|
      format.html # indexbak.html.erb
      format.xml { render :xml => @position }
    end
  end
end
