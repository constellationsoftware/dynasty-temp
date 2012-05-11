class PlayerTeamObserver < ActiveRecord::Observer
    def before_create(player_team)
        lineup = Lineup.empty(player_team.team_id).by_position(player_team.player.player_position.position_id).first
        player_team.lineup_id = lineup.id unless lineup.nil?
    end

    def before_update(player_team)
        # when someone JUST dropped a player
        if player_team.team_id.nil? && !(player_team.team_id_was.nil?)
            # pay guaranteed salary to player
            guaranteed_salary_event = Events::PayGuaranteedSalary.create!
            guaranteed_salary_event.process player_team, player_team.team_id_was
        end
    end
end
