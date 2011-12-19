class LeagueObserver < ActiveRecord::Observer


  def before_save(league)
    #league.name = league.name
  end
	#def after_create(model)
    #    1.times do
	#       model.drafts.create
    #       model.teams.picks.update
    #    end  
    #end
end
