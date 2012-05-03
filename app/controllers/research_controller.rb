class ResearchController < ApplicationController
  #caches_page :index

  def index
   @players ||= Player.current.research.all



  end



  def team
  end

  def player
    @player ||= Player(params[:id])
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
