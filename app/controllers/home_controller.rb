class HomeController < ApplicationController

  # get a list of the players but dont load much info
  def index
    @title = 'Dynasty Owner'
    @players ||= Player.current.research

    # pull in basic info on one player
    if params[:player_id]
      @player ||= Player.find(params[:player_id], :include => [:contract, :position, :points])
    end

    #get a collection?
    #
    if params[:position_id]

    end
  end

  def playersomething

  end

  # pull in detailed player info

  def show
    @player = Player.find(params[:id])
  end
end
