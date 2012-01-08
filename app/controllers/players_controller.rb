class PlayersController < ApplicationController
  def show
    @player = Player.with_points_from_season(2011).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end
end
