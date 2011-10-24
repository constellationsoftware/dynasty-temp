class StatsController < ApplicationController
  def index
    @stats = Stat.all
    @stats.each do |s|
      s.stat_repository_type = s.stat_repository_type.camelize.to_s
      s.stat_repository_type = s.stat_repository_type.singularize.to_s
      s.save
    end


    respond_to do |format|
      format.html # indexbak.html.erb
      format.xml { render :xml => @stats }
    end
  end
end
