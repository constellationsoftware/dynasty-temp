class LeagueObserver < ActiveRecord::Observer
    def before_update(league)
        league.team_count = league.teams.size
    end
end
