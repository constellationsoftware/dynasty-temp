class PlayerTeamRecordObserver < ActiveRecord::Observer
    def before_update(player_team)
        # when someone JUST dropped a player
        if player_team.user_team_id.nil? && !(player_team.user_team_id_was.nil?)
            # pay guaranteed salary to player
            guaranteed_salary_event = Events::PayGuaranteedSalary.create!
            guaranteed_salary_event.process player_team, player_team.user_team_id_was
        end
    end
end
