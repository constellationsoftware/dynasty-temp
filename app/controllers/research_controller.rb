class ResearchController < ApplicationController

  def index
   @players = Player.current.with_contract.all

    @teams = SportsDb::Team.nfl.includes(:display_name)


  end

  def team
  end

  def player
    @players = Player.all
    render :json => @players
  end


  def news
  end

  def transactions
  end

  def contracts
  end

  def depth_charts
  end
end
