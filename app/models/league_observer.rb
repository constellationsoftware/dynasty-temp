class LeagueObserver < ActiveRecord::Observer
	def after_create(league)
	   Draft.create
    league.size.times do
      UserTeam.create
    end
  end
end
