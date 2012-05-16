class ResearchController < ApplicationController
  caches_page :index

  def index
   #@players ||= Player.current.research.includes(:contract, :name, :position, :points)
   @players ||= all_real_players
   @teams ||= all_real_teams
  end

  def pjax
    @players ||= all_real_players
   @teams ||= all_real_teams
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
