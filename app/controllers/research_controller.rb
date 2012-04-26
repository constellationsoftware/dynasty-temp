class ResearchController < ApplicationController
  caches_page :index

  def index
   @players ||= Player.current.research.all


   #respond_to do |format|
   #  format.html
   #  format.json { render json: ProductsDatatable.new(view_context) }
   #end
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
