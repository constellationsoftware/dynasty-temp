class ResearchController < ApplicationController

  def index
    @teams = SportsDb::Team.nfl.includes(:display_name)
  end

  def team
  end

  def player
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
